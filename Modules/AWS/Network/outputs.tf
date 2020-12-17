

output "aws_vpc" {
  value = aws_vpc.network_vpc.id
}

# output "aws_nat_gateway" {
#   value = aws_nat_gateway.network_nat_gateway.*.id
# }

output "aws_security_group" {
  value = aws_security_group.network_default_sg.id
}

output "aws_private_subnet" {
  value = aws_subnet.network_private_subnet[0].id
}

output "aws_private_subnets" {
  value = aws_subnet.network_private_subnet.*.id
}

output "additional_cidr_blocks" {
  description = "A list of the additional IPv4 CIDR blocks associated with the VPC"
  value = [
    for i in aws_vpc_ipv4_cidr_block_association.network_vpc_cidr_assoc :
    i.cidr_block
    if local.additional_cidr_blocks_defined
  ]
}

output "additional_cidr_blocks_to_association_ids" {
  description = "A map of the additional IPv4 CIDR blocks to VPC CIDR association IDs"
  value = {
    for i in aws_vpc_ipv4_cidr_block_association.network_vpc_cidr_assoc :
    i.cidr_block => i.id
    if local.additional_cidr_blocks_defined
  }
}