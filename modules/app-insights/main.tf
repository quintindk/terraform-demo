resource "azurerm_application_insights" "appinsights" {
  name                = "${var.base_name}-appinsights"
  location            = var.region
  resource_group_name = var.rg_name
  application_type    = var.app_type

    tags = merge({
    Environment = var.environment
    Product     = var.base_name
  }, var.tags)
}

