
data "template_file" "user_data" {
  count    = module.this.enabled ? 1 : 0
  template = var.user_data

  vars = {
    user_data       = join("\n", var.user_data)
    welcome_message = var.global_tags
    hostname        = "${module.this.name}.${join("", data.aws_route53_zone.domain.*.name)}"
    search_domains  = join("", data.aws_route53_zone.domain.*.name)
    ssh_user        = var.ssh_user
  }
}

data "aws_route53_zone" "domain" {
  count   = var.zone_id != "" ? 1 : 0
  zone_id = var.zone_id
}

resource "aws_instance" "bastion_instance" {
  count         = 1
  ami           = var.ami
  instance_type = var.instance_type

  user_data = data.template_file.user_data[0].rendered

  vpc_security_group_ids = compact(concat(aws_security_group.default.*.id, var.security_groups))

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

module "dns" {
  source  = "../DNS"
  enabled = true
  name    = module.this.name
  zone_id = var.zone_id
  ttl     = 60
  records = var.associate_public_ip_address ? aws_instance.default.*.public_dns : aws_instance.default.*.private_dns
}