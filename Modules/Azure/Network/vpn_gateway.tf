# resource "azurerm_virtual_wan" "vwan" {
#   name                = var.vwan_name
#   resource_group_name = var.rg_name
#   location            = var.location
#   tags                = merge({
#                           "Created On" = var.created_on
#                         }, var.tags)
# }

# resource "azurerm_virtual_hub" "vhub" {
#   name                = var.vhub_name
#   resource_group_name = var.rg_name
#   location            = var.location
#   virtual_wan_id      = azurerm_virtual_wan.vwan.id
#   address_prefix      = var.address_prefix
#   tags                = merge({
#                           "Created On" = var.created_on
#                         }, var.tags)
# }

# resource "azurerm_vpn_gateway" "vpngw" {
#   name                = var.vpngw_name
#   location            = var.location
#   resource_group_name = var.rg_name
#   virtual_hub_id      = azurerm_virtual_hub.vhub.id

#   tags                = merge({
#                           "Created On" = var.created_on
#                         }, var.tags)
# }

resource "azurerm_public_ip" "vpnpip" {
  name                = var.vpnpip_name
  location            = var.location
  resource_group_name = var.rg_name

  allocation_method   = "Dynamic"

  tags                = merge({
                          Name   = "Terraform project vpn ip"
                        }, var.tags)
}

resource "azurerm_virtual_network_gateway" "vnetgw" {
  name                = var.vnetgw_name
  location            = var.location
  resource_group_name = var.rg_name

  type                = "Vpn"
  vpn_type            = "RouteBased"

  active_active       = false
  enable_bgp          = false
  sku                 = "Basic"

  ip_configuration {
    name                          = "VnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.vpnpip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.vnet_subnet_id
  }

  tags                = merge({
                          Name   = "Terraform project vpn gateway"
                        }, var.tags)
}