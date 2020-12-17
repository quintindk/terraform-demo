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

  tags = module.this.tags

#   metadata_options {
#     http_endpoint               = (var.metadata_http_endpoint_enabled) ? "enabled" : "disabled"
#     http_put_response_hop_limit = var.metadata_http_put_response_hop_limit
#     http_tokens                 = (var.metadata_http_tokens_required) ? "required" : "optional"
#   }

  root_block_device {
    encrypted   = var.root_block_device_encrypted
    volume_size = var.root_block_device_volume_size
  }
}