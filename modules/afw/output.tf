output "id" {
  value = azurerm_firewall.fw.id
}
output "name" {
  value = azurerm_firewall.fw.name
}
output "ip" {
  value = azurerm_public_ip.fw_pip.ip_address
}
