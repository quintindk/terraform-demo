# Global Variables
variable "region" {
  description = "The region to deploy the resources in."
  default     = "southafricanorth"
}
variable "environment" {
  description = "The environment that the resources are deployed for."
  default     = ""
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

# VNET Vars
variable "address_spaces" {
  description = "An array of address spaces to use in this VNET instance."
  default     = null
  type        = list(string)
}

variable "dns_servers" {
  description = "An array of DNS servers to use in the VNET."
  default     = null
  type        = list(string)
}