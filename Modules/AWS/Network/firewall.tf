
#
# Private Network ACLs
#
resource "aws_network_acl" "firewall_private_nacl" {
  count = var.az_count

  vpc_id     = aws_vpc.network_vpc.id
  subnet_ids = aws_subnet.firewall_private_subnet.*.id
  depends_on = [ aws_subnet.firewall_private_subnet ]
  tags = merge(
    {
      "Name" = "Firewall private nacl"
    },
    var.global_tags,
  )
}

resource "aws_network_acl_rule" "pivate_inbound" {
  count = length(var.pivate_inbound_acl_rules)

  network_acl_id = aws_network_acl.firewall_private_nacl[0].id

  egress          = false
  rule_number     = var.pivate_inbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.pivate_inbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.pivate_inbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.pivate_inbound_acl_rules[count.index], "to_port", null)
  icmp_code       = lookup(var.pivate_inbound_acl_rules[count.index], "icmp_code", null)
  icmp_type       = lookup(var.pivate_inbound_acl_rules[count.index], "icmp_type", null)
  protocol        = var.pivate_inbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.pivate_inbound_acl_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.pivate_inbound_acl_rules[count.index], "ipv6_cidr_block", null)
}

resource "aws_network_acl_rule" "pivate_outbound" {
  count = length(var.pivate_outbound_acl_rules)

  network_acl_id = aws_network_acl.firewall_private_nacl[0].id

  egress          = true
  rule_number     = var.pivate_outbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.pivate_outbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.pivate_outbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.pivate_outbound_acl_rules[count.index], "to_port", null)
  icmp_code       = lookup(var.pivate_outbound_acl_rules[count.index], "icmp_code", null)
  icmp_type       = lookup(var.pivate_outbound_acl_rules[count.index], "icmp_type", null)
  protocol        = var.pivate_outbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.pivate_outbound_acl_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.pivate_outbound_acl_rules[count.index], "ipv6_cidr_block", null)
}
