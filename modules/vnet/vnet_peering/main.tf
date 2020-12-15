# data "azurerm_virtual_network" "hubvnet" {
#   name                = var.hubvnetname
#   resource_group_name = var.rg_name
# }

# output "hubvnet_id" {
#   value = data.azurerm_virtual_network.hubvnet.id
# }

# data "azurerm_virtual_network" "spokevnet" {
#   name                = var.spokevnetname
#   resource_group_name = var.rg_name
# }

# output "spokevnet_id" {
#   value = data.azurerm_virtual_network.spokevnet.id
# }

resource "azurerm_virtual_network_peering" "hubvnet" {
  name                      = "hubtospoke"
  resource_group_name       = var.rg_name
  virtual_network_name      = var.hubvnetname
  remote_virtual_network_id = var.spokevnet_id
}
resource "azurerm_virtual_network_peering" "spokevnet" {
  name                      = "spoketohub"
  resource_group_name       = var.rg_name
  virtual_network_name      = var.spokevnetname
  remote_virtual_network_id = var.hubvnet_id
}