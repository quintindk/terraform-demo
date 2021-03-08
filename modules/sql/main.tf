resource "random_string" "username" {
  length  = 12
  special = false
}

resource "random_password" "password" {
  length           = 32
  min_upper        = 4
  number           = true
  min_numeric      = 4
  special          = true
  min_special      = 4
  override_special = "_%@"
}

resource "azurerm_sql_server" "sql" {
  name                         = var.environment != "" ? "sql-${var.base_name}-${var.environment}" : "sql-${var.base_name}"
  resource_group_name          = var.rg_name
  location                     = var.region
  version                      = "12.0"
  administrator_login          = random_string.username.result
  administrator_login_password = random_password.password.result

  tags = merge({
    Environment = var.environment
    Product     = var.base_name
  }, var.tags)
}

resource "azurerm_key_vault_secret" "sqluser" {
  name         = "sqluser"
  value        = random_string.username.result
  key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_secret" "sqlpassword" {
  name         = "sqlpass"
  value        = random_password.password.result
  key_vault_id = var.key_vault_id
}
