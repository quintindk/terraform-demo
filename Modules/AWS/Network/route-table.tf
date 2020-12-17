
resource "aws_route_table" "network_private_rt" {
  # name = "network_private_rt_${var.resource_name}"
  vpc_id = aws_vpc.network_vpc.id
  tags = merge(
    var.global_tags,
    {
      "Name" = "Network Private rt"
    },
  )
}

resource "aws_route" "network_igw_route" {
  count                  = var.az_count
  route_table_id         = aws_route_table.network_private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id         = aws_internet_gateway.network_igw.id
  timeouts {
    create = "5m"
  }
}

# resource "aws_route" "network_private_nat_route" {
#   count                  = var.az_count
#   route_table_id         = aws_route_table.network_private_rt.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = element(aws_nat_gateway.network_nat_gateway.*.id, count.index)
#   timeouts {
#     create = "5m"
#   }
# }