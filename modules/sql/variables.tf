variable "region" {
  description = "The region to deploy the resources to."
  default     = "westeurope"
  type        = string
}
variable "environment" {
  description = "The environment that the resources are deployed for."
  default     = ""
  type        = string
}
variable "base_name" {
  description = "The base name to use for all resources."
  default     = ""
  type        = string
}
variable "rg_name" {
  description = "The name of the resource group to deploy to."
  type        = string
}
variable "key_vault_id" {
  description = "ID of the Key Vault to save database credentials."
  type        = string
}
variable "tags" {
  description = "The tags to add to the deployed resources."
  default     = {}
}
