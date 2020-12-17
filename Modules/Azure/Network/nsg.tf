resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-${var.base_name}-${var.group_name}-${var.environment}-${var.region}"
  location            = var.region
  resource_group_name = var.rg_name

  dynamic "security_rule" {
    for_each = var.security_rules

    content {
      name                         = security_rule.value.name
      priority                     = security_rule.value.priority
      direction                    = security_rule.value.direction
      access                       = security_rule.value.access
      protocol                     = security_rule.value.protocol

      source_port_range            = security_rule.value.source_port_ranges[0] == "*" ? "*" : null
      source_port_ranges           = security_rule.value.source_port_ranges[0] == "*" ? null : security_rule.value.source_port_ranges

      source_address_prefix        = security_rule.value.source_address_prefixes[0] == "*" ? "*" : null
      source_address_prefixes      = security_rule.value.source_address_prefixes[0] == "*" ? null : security_rule.value.source_address_prefixes

      destination_port_range       = security_rule.value.destination_port_ranges[0] == "*" ? "*" : null
      destination_port_ranges      = security_rule.value.destination_port_ranges[0] == "*" ? null : security_rule.value.destination_port_ranges

      destination_address_prefix   = security_rule.value.destination_address_prefixes[0] == "*" ? "*" : null
      destination_address_prefixes = security_rule.value.destination_address_prefixes[0] == "*" ? null : security_rule.value.destination_address_prefixes
    }
  }

  tags = merge({
    Name   = "Terraform project NSG"
  }, var.tags)
}
