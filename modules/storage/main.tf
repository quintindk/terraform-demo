resource "azurerm_storage_account" "storage" {
  name                = "stor${var.environment}${var.base_name}"
  resource_group_name = var.rg_name
  location            = var.region

  account_kind              = var.type
  account_tier              = var.tier
  account_replication_type  = var.replication
  access_tier               = var.access_tier
  enable_https_traffic_only = var.https_only

  dynamic "network_rules" {
    for_each = var.network_rules
    content {
      default_action             = network_rules.value.action
      ip_rules                   = network_rules.value.ip_rules
      virtual_network_subnet_ids = network_rules.value.subnet_ids
    }
  }

  tags = merge({
    Environment    = var.environment
    Product        = var.base_name
  }, var.tags)
}
