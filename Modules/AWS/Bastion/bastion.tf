
data "template_file" "user_data" {
  count    = 1
  template = var.user_data

  vars = {
    welcome_message = "Bastion"
    user_data = ""
    //not ptovision route for the time being. 
    hostname        = "${var.hostname}.${join("", data.aws_route53_zone.domain.*.name)}"
    search_domains  = join("", data.aws_route53_zone.domain.*.name)
    ssh_user        = var.ssh_user
  }
}

data "aws_route53_zone" "domain" {
  count   = var.zone_id != "" ? 1 : 0
  zone_id = var.zone_id
}

data "aws_iam_policy_document" "default" {
  statement {
    sid = ""

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    effect = "Allow"
  }
}

resource "aws_iam_instance_profile" "default" {
  count = 1
  name  = "bastion_default_profile"
  role  = aws_iam_role.default[0].name
}

resource "aws_iam_role" "default" {
  count = 1
  name  = "bastion_default_iam"
  path  = "/"

  assume_role_policy = data.aws_iam_policy_document.default.json
}

resource "aws_instance" "bastion_instance" {
  count         = 1
  ami           = var.ami
  instance_type = var.instance_type

  //user_data = data.template_file.user_data[0].rendered
  user_data = var.user_data

  vpc_security_group_ids = compact(concat(aws_security_group.bastion_sg.*.id, [var.default_security_group]))

  iam_instance_profile        = aws_iam_instance_profile.default[0].name
  associate_public_ip_address = var.associate_public_ip_address

  key_name = var.key_name

  subnet_id = var.subnets[0]

  tags = var.global_tags

  root_block_device {
    encrypted   = var.root_block_device_encrypted
    volume_size = var.root_block_device_volume_size
  }
}
/*
module "dns" {
  source  = "../DNS"
  name    = var.hostname
  zone_id = var.zone_id
  ttl     = 60
  records = var.associate_public_ip_address ? aws_instance.bastion_instance.*.public_dns : aws_instance.bastion_instance.*.private_dns
}*/