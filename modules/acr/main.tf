resource "random_id" "key_vault" {
  keepers = {
    # Generate a new name each time we change the base and/or environment variable
    acr_name = "${var.base_name}-${var.environment}"
  }

  byte_length = 2
}

resource "azurerm_container_registry" "acr" {
  name                = var.environment != "" ? replace("acr-${var.base_name}-${var.environment}-${random_id.key_vault.hex}", "/([-\\*])/", "") : replace("acr-${var.base_name}-${random_id.key_vault.hex}", "/([-\\*])/", "") 
  resource_group_name = var.rg_name
  location            = var.region
  sku                 = var.sku
  admin_enabled       = var.admin
  
  tags = merge({
    Environment = var.environment
    Base        = var.base_name
  }, var.tags)
}
