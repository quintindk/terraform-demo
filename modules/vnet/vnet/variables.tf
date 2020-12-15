# Global Variables
variable "region" {
  description = "The region to deploy the resources in."
}
variable "environment" {
  description = "The environment that the resources are deployed for."
}
variable "base_name" {
  description = "The base name to use for all resources."
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
variable "subnets" {
  description = "An array of subnets to configure on the VNET instance. See documentation for more information."
  default     = null
  type        = list(object({
    name              = string
    address_prefix    = string
    security_group_id = string
  }))
}