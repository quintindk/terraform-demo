# Global Vars
variable "region" {
  description = "The region to deploy the resources in."
}
variable "environment" {
  description = "The environment the ACR"
  default = ""
}
variable "base_name" {
  description = "The base name to use for all resources."
}
variable "tags" {
  description = "The tags to add to the deployed resources."
}

# Resource Group
variable "rg_name" {
  description = "The name of the resource group to deploy in."
}

# Specific Vars
variable "admin" {
  description = "Whether admin access should be enabled or not."
  type        = bool
}

variable "sku" {
  description = "The SKU of the ACR."
  type        = string
  validation {
    condition     = var.sku == "Standard" || var.sku == "Premium" || var.sku == "Basic"
    error_message = "The sku value must be 'Standard' or 'Premium'."
  }
}