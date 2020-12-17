resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.base_name}-${var.environment}-${var.region}"
  location            = var.region
  resource_group_name = var.rg_name

  address_space = var.address_spaces
  dns_servers   = var.dns_servers

  tags = merge({
    Name   = "Terraform project vnet"
  }, var.tags)
}