resource "random_id" "key_vault" {
  keepers = {
    key_vault = "${var.base_name}${var.environment}"
  }

  byte_length = 2
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "akv" {
  name                        = "akv-${var.base_name}-${var.environment}-${random_id.key_vault.hex}"
  location                    = var.region
  resource_group_name         = var.rg_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  purge_protection_enabled    = false
  sku_name                    = "standard"
  //enable_rbac_authorization   = false

  dynamic "access_policy" {
    for_each = var.access_policies

    content {
      tenant_id                = data.azurerm_client_config.current.tenant_id
      object_id                = data.azurerm_client_config.current.object_id
      certificate_permissions  = access_policy.value["certificate_permissions"]
      key_permissions          = access_policy.value["key_permissions"]
      secret_permissions       = access_policy.value["secret_permissions"]
      storage_permissions      = access_policy.value["storage_permissions"]
    }
  }

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }

  tags = merge({
    Environment = var.environment
    Product     = var.base_name
  }, var.tags)
}