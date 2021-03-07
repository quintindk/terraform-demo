resource "azurerm_application_insights" "ai" {
  name                = var.environment != "" ? "ai-${var.base_name}-${var.environment}" : "ai-${var.base_name}"
    location            = var.region
    resource_group_name = var.rg_name
    application_type    = var.application_type
}
