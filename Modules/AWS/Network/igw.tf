resource "aws_internet_gateway" "network_igw" {
#   name = "network_igw_${var.resource_name}"
  vpc_id = aws_vpc.network_vpc.id
  tags = merge(
    var.global_tags,
    {
      "Name" = "Network IGW"
    },
  )
  depends_on = [
    aws_vpc.network_vpc,
  ]
}