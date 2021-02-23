resource "random_id" "sequence" {
  keepers = {
    vnetpeers = "${var.source_vnet_name}${var.remote_vnet_name}"
  }

  byte_length = 2
}

resource "azurerm_virtual_network_peering" "hubvnet" {
  name                      = "forward${random_id.sequence.hex}"
  resource_group_name       = var.forward_rg_name
  virtual_network_name      = var.source_vnet_name
  remote_virtual_network_id = var.remote_vnet_id
}

resource "azurerm_virtual_network_peering" "spokevnet" {
  name                      = "reverse${random_id.sequence.hex}"
  resource_group_name       = var.reverse_rg_name
  virtual_network_name      = var.remote_vnet_name
  remote_virtual_network_id = var.source_vnet_id
}