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
