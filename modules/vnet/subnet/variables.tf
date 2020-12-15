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
  description = "The name of this specific subnet group."
}

# Resource Group
variable "rg_name" {
  description = "The name of the resource group to deploy in."
}

# Subnet Vars
variable "is_gateway" {
  description = "Set to true to overwrite the generated name and use 'GatewaySubnet' instead."
  type        = bool
  default     = false
}
variable "vnet_name" {
  description = "The name of the VNET to create the subnet in."
}
variable "address_prefixes" {
  description = "The address prefixes to use for the subnet."
  type        = list(string)
}
variable "has_nsg" {
  description = "Does this subnet have a linked NSG."
  default     = false
}
variable "nsg_id" {
  description = "The ID of a network security group to associate to this subnet."
  default     = null
}
variable "service_endpoints" {
  type    = list(string)
  default = []
}