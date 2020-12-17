# resource "azurerm_virtual_network" "example" {
#   name                = "testvnet"
#   address_space       = ["10.0.0.0/16"]
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name
# }
# resource "azurerm_subnet" "example" {
#   name                 = "AzureFirewallSubnet"
#   resource_group_name  = azurerm_resource_group.example.name
#   virtual_network_name = azurerm_virtual_network.example.name
#   address_prefix       = "10.0.1.0/24"
# }
resource "azurerm_public_ip" "azpubip" {
  name                = var.pubipname
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                     = merge({
                                Name   = "Terraform project public IP"
                            }, var.tags)
}
resource "azurerm_firewall" "azfirewall" {
  name                = var.firewallname
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                     = merge({
                                Name   = "Terraform project Firewall"
                            }, var.tags)
  ip_configuration {
    name                 = "AzureFirewallSubnet"
    subnet_id            = var.azurerm_subnet_id
    public_ip_address_id = azurerm_public_ip.azpubip.id
  }
}
/*
resource "azurerm_firewall_network_rule_collection" "example" {
  name                = "testcollection"
  azure_firewall_name = azurerm_firewall.example.name
  resource_group_name = azurerm_resource_group.example.name
  priority            = 100
  action              = "Allow"
  rule {
    name = "testrule"
    source_addresses = [
      "10.0.0.0/16",
    ]
    destination_ports = [
      "53",
    ]
    destination_addresses = [
      "8.8.8.8",
      "8.8.4.4",
    ]
    protocols = [
      "TCP",
      "UDP",
    ]
  }
}
*/