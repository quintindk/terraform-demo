resource "azurerm_sql_server" "sqlserver" {
  name                         = "${var.base_name}-sqlserver"
  resource_group_name          = var.rg_name
  location                     = var.region
  version                      = var.db_version
  administrator_login          = var.admin_login
  administrator_login_password = var.admin_pass


resource "azurerm_storage_account" "storageacc" {
  name                     = "${var.base_name}-storageacc"
  resource_group_name      = var.rg_name
  location                 = var.region
  account_tier             = var.tier
  account_replication_type = var.replication_type
}

resource "azurerm_sql_database" "db" {
  name                = "${var.base_name}-sqldatabase"
  resource_group_name = var.rg_name
  location            = var.region
  server_name         = azurerm_sql_server.sqlserver.name

  extended_auditing_policy {
    storage_endpoint                        = azurerm_storage_account.storageacc.primary_blob_endpoint
    storage_account_access_key              = azurerm_storage_account.storageacc.primary_access_key
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 6
  }

  tags = merge({
    Environment = var.environment
    Base        = var.base_name
  }, var.tags)


}