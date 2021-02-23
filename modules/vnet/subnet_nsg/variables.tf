# Global Variables
variable "environment" {
  description = "The environment that the resources are deployed for."
}
variable "base_name" {
  description = "The base name to use for all resources."
}

# Resource Group
variable "rg_name" {
  description = "The name of the resource group to deploy in."
}

# Subnet Vars
variable "name" {
  description = "The name of the subnet."
  default     = ""
}
variable "vnet_name" {
  description = "The name of the VNET to create the subnet in."
}
variable "address_prefixes" {
  description = "The address prefix to use for the subnet."
  type = list(string)
}
variable "nsg_id" {
  description = "The ID of a network security group to associate to this subnet."
  default     = null
}