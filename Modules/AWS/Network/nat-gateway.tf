
resource "aws_nat_gateway" "network_nat_gateway" {
  count         = var.az_count
  allocation_id = element(aws_eip.network_eip.*.id, count.index)
  subnet_id     = element(aws_subnet.network_public_subnet.*.id, count.index)
  tags = merge(
    var.global_tags,
    {
      "Name" = "network_nat_${count.index + 1}"
    },
  )
  depends_on = [
    aws_eip.network_eip,
    aws_subnet.network_public_subnet,
  ]
  
}
