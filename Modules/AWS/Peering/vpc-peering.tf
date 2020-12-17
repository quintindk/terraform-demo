resource "aws_vpc_peering_connection" "vpc_network_peering" {
  count       = 1
  vpc_id      = join("", data.aws_vpc.requestor.*.id)
  peer_vpc_id = join("", data.aws_vpc.acceptor.*.id)

  auto_accept = var.auto_accept

  accepter {
    allow_remote_vpc_dns_resolution = var.acceptor_allow_remote_vpc_dns_resolution
  }

  requester {
    allow_remote_vpc_dns_resolution = var.requestor_allow_remote_vpc_dns_resolution
  }

  tags = merge(
    {
      "Name" = "default vpc network peering"
    },
    var.global_tags,
  )

  timeouts {
    create = var.create_timeout
    update = var.update_timeout
    delete = var.delete_timeout
  }
}

data "aws_vpc" "requestor" {
  count = 1
  id    = var.requestor_vpc_id
  tags = merge(
    {
      "Name" = "requestor vpc"
    },
    var.global_tags,
  )
}

data "aws_vpc" "acceptor" {
  count = 1
  id    = var.acceptor_vpc_id
  tags = merge(
    {
      "Name" = "acceptor vpc"
    },
    var.global_tags,
  )
}

data "aws_route_tables" "requestor" {
  count  = 1
  vpc_id = join("", data.aws_vpc.requestor.*.id)
  tags = merge(
    {
      "Name" = "requestor rt"
    },
    var.global_tags,
  )
}

data "aws_route_tables" "acceptor" {
  count  = 1
  vpc_id = join("", data.aws_vpc.acceptor.*.id)
  tags = merge(
    {
      "Name" = "acceptor rt"
    },
    var.global_tags,
  )
}

resource "aws_route" "requestor" {
  count                     = 1
  route_table_id            = element(distinct(sort(data.aws_route_tables.requestor[0].ids)), ceil(count.index / 1))
  destination_cidr_block    = data.aws_vpc.acceptor[0].cidr_block_associations[count.index % 1]["cidr_block"]
  vpc_peering_connection_id = join("", aws_vpc_peering_connection.vpc_network_peering.*.id)
  depends_on                = [data.aws_route_tables.requestor, aws_vpc_peering_connection.vpc_network_peering]
}

resource "aws_route" "acceptor" {
  count                     = 1
  route_table_id            = element(distinct(sort(data.aws_route_tables.acceptor[0].ids)), ceil(count.index / 1))
  destination_cidr_block    = data.aws_vpc.requestor[0].cidr_block_associations[count.index % 1]["cidr_block"]
  vpc_peering_connection_id = join("", aws_vpc_peering_connection.vpc_network_peering.*.id)
  depends_on                = [data.aws_route_tables.acceptor, aws_vpc_peering_connection.vpc_network_peering]
}