resource "azurerm_api_management" "apim" {
  name                = "apim-${var.base_name}-${var.environment}"
  location            = var.region
  resource_group_name = var.rg_name
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email

  sku_name = "${var.sku_name}_${var.node_count}"

  dynamic "certificate" {
    for_each = var.ca_certificates

    content {
      encoded_certificate   = certificate.value.base64_encoded_certificate
      certificate_password  = certificate.value.certificate_password
      store_name            = certificate.value.store_name
    }
  }

  policy {
    xml_content = <<XML
    <policies>
      <inbound />
      <backend />
      <outbound />
      <on-error />
    </policies>
XML
  }

  identity {
    type          = var.identity_type
    # identity_ids  = var.user_assigned_ids -- wondering if I this ?
  }

  tags = merge({
    Environment = var.environment
    Product     = var.base_name
  }, var.tags)
}
