resource "azurerm_public_ip" "fw_pip" {
  name = var.environment != "" ? "fw-pip-${var.base_name}-${var.environment}" : "fw-pip-${var.base_name}"
  location = var.region
  resource_group_name = var.rg_name
  allocation_method = "Static"
  sku = var.fw_pip_sku
}

resource "azurerm_firewall" "fw" {
  name = var.environment != "" ? "fw-${var.base_name}-${var.environment}" : "fw-${var.base_name}"
  location = var.region
  resource_group_name = var.rg_name

  ip_configuration {
    name = var.environment != "" ? "pip-config-${var.base_name}-${var.environment}" : "pip-config-${var.base_name}"
    subnet_id = var.subnet_id
    public_ip_address_id = azurerm_public_ip.fw_pip.id
  }
}
