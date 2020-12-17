
locals {
  additional_cidr_blocks_defined                  = var.additional_cidr_blocks != null ? true : false
  additional_cidr_blocks                          = local.additional_cidr_blocks_defined ? var.additional_cidr_blocks : []
}

resource "aws_vpc" "network_vpc" {
  # name = "network_vpc_${var.resource_name}"
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = var.vpc_instance_tenancy
  enable_dns_support   = var.vpc_enable_dns_support
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  enable_classiclink   = var.vpc_enable_classiclink
  tags = merge(
    var.global_tags,
    {
      "Name" = "Network VPC"
    },
  )
}

resource "aws_vpc_ipv4_cidr_block_association" "network_vpc_cidr_assoc" {
  for_each   = toset(local.additional_cidr_blocks)
  vpc_id     = join("", aws_vpc.network_vpc.*.id)
  cidr_block = each.key
}