

######### firewall output #########
output "firewall_ip_configuration" {
  value = azurerm_firewall.azfirewall.ip_configuration
}
output "firewall_id" {
  value = azurerm_firewall.azfirewall.id
}
output "pubip_id" {
  value = azurerm_public_ip.azpubip.id
}
output "pubip_address" {
  value = azurerm_public_ip.azpubip.ip_address
}
#########################################



######## nsg output #####################
output "name" {
  value = azurerm_network_security_group.nsg.name
}
output "id" {
  value = azurerm_network_security_group.nsg.id
}
#########################################




######## resource group output #########
output "name" {
  value = azurerm_resource_group.rg.name
}
output "region" {
  value = azurerm_resource_group.rg.location
}
#########################################




############### subnet output ##########
output "name" {
  value = azurerm_subnet.subnet.name
}
output "id" {
  value = azurerm_subnet.subnet.id
}
########################################




############ vpn ########################
output "name" {
  value = azurerm_subnet.subnet.name
}
output "id" {
  value = azurerm_subnet.subnet.id
}
########################################




############ vpc peering ########################
output "name" {
  value = azurerm_subnet.subnet.name
}
output "id" {
  value = azurerm_subnet.subnet.id
}
#################################################



############ vpn gateway ########################
output "vpngw_id" {
  value = azurerm_vpn_gateway.vpngw.id
}

output "vpngw_bgp_settings" {
  value = azurerm_vpn_gateway.vpngw.bgp_settings
}
#################################################