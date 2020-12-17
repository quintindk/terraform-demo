
resource "aws_route_table" "network_private_rt" {
  vpc_id = aws_vpc.network_vpc.id
  tags = merge(
    var.global_tags,
    {
      "Name" = "Network Private rt"
    },
  )
}

resource "aws_route" "network_private_route" {
  count                  = var.multi_az_nat_gateway * var.az_count
  route_table_id         = aws_route_table.network_private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.network_nat_gateway.id
}