
resource "aws_eip" "network_eip" {
  # name = "network_eip_${var.resource_name}"
  count = var.az_count
  vpc   = true
  tags = merge(
    var.global_tags,
    {
      "Name" = "network_eip_${count.index + 1}"
    },
  )
}
