# Global Variables
variable "region" {
  description = "The region to deploy the resources in."
  default     = "southafricanorth"
}
variable "environment" {
  description = "The environment that the resources are deployed for."
  default     = "dev"
}
variable "base_name" {
  description = "The base name to use for all resources."
  default     = ""
}
variable "tags" {
  description = "The tags to add to the deployed resources."
  default     = {}
}

# Resource Group
variable "rg_name" {
  description = "The name of the resource group to deploy in."
}

# Storage Vars
variable "type" {
  description = "The type of storage account to create. See documentation for more information."
  default     = "StorageV2"
  type        = string
}
variable "tier" {
  description = "The tier to use for this storage account. See documentation for more information."
  default     = "Standard"
  type        = string
}
variable "replication" {
  description = "The type of replication to use for this storage account. See the documentation for more information."
  default     = "LRS"
  type        = string
}
variable "access_tier" {
  description = "The access the tier to use for this storage account. See documentation for more information."
  default     = null
  type        = string
}
variable "https_only" {
  description = "Whether to limit all traffic to HTTPS or not."
  default     = true
  type        = bool
}
variable "network_rules" {
  description = "An array of network rules for this blob instance. See documentation for more information."
  default     = []
  type        = list(object({
    action     = string
    ip_rules   = list(string)
    subnet_ids = list(string)
  }))
}
