

resource "aws_subnet" "network_private_subnet" {
  # name = "network_private_subnet_${var.resource_name}"
  count             = var.az_count
  vpc_id            = aws_vpc.network_vpc.id
  cidr_block        = "${var.vpc_cidr_base}${var.private_subnet_cidrs[format("zone%d", count.index)]}"
  availability_zone = element(split(", ", var.aws_azs), count.index)
  tags = merge(
    var.global_tags,
    {
      "Name" = "Network private subnet az${count.index + 1}"
    },
  )
  depends_on = [
    aws_vpc.network_vpc,
  ]
}

resource "aws_route_table_association" "subnets_private_rt_assoc" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.network_private_subnet.*.id, count.index)
  route_table_id = aws_route_table.network_private_rt.id
}