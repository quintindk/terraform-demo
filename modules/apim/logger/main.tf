resource "azurerm_api_management_logger" "logger" {
  name                = "apim-logger-${var.apim_name}"
  api_management_name = var.apim_name
  resource_group_name = var.rg_name

  dynamic "application_insights" {
    for_each = var.instrumentation_key != null ? [var.instrumentation_key] : []

    content {
      instrumentation_key = var.instrumentation_key
    }
  }

  dynamic "eventhub" {
    for_each = var.evh_name != null ? [var.evh_name] : []

    content {
      name = var.evh_name
      connection_string = var.evh_connection_string
    }
  }
}
