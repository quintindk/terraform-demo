resource "azurerm_subnet" "subnet" {
  name                 = var.is_gateway == true ? "GatewaySubnet" : "snet-${var.base_name}-${var.group_name}-${var.environment}-${var.region}"
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.address_prefixes
  service_endpoints    = var.service_endpoints
}

resource "azurerm_subnet_network_security_group_association" "subnet_assoc" {
  count                     = var.has_nsg ? 1 : 0
  network_security_group_id = var.nsg_id
  subnet_id                 = azurerm_subnet.subnet.id
}