

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