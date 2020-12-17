# Create the resource group.
resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.base_name}-${var.environment}-${var.region}"
  location = var.region

  tags = merge({
    Name   = "Terraform project Resource group"
  }, var.tags)
}