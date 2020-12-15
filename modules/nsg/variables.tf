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
variable "group_name" {
  description = "The name of this specific NSG."
}
variable "tags" {
  description = "The tags to add to the deployed resources."
  default     = {}
}

# Resource Group
variable "rg_name" {
  description = "The name of the resource group to deploy in."
}

# NSG Vars
variable "security_rules" {
  description = "An array of security rules to apply to the NSG. See documentation for more information."
  default     = []
  type        = list(object({
    name                         = string
    priority                     = number
    direction                    = string
    access                       = string
    protocol                     = string
    source_port_ranges           = list(string)
    destination_port_ranges      = list(string)
    source_address_prefixes      = list(string)
    destination_address_prefixes = list(string)
  }))
}
