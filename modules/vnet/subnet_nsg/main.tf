resource "azurerm_subnet" "subnet" {
  name                  = var.name != "" ? var.name : "snet${var.base_name}${var.environment}"
  resource_group_name   = var.rg_name
  virtual_network_name  = var.vnet_name
  address_prefixes      = var.address_prefixes
}

resource "azurerm_subnet_network_security_group_association" "subnet_assoc" {
  network_security_group_id = var.nsg_id
  subnet_id                 = azurerm_subnet.subnet.id
}