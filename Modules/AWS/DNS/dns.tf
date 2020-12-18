resource "aws_route53_record" "bastion_record" {
  count   = 1
  name    = var.dns_name
  zone_id = var.zone_id
  type    = var.type
  ttl     = var.ttl
  records = var.records
}