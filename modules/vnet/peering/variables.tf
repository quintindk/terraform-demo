# Resource Group
variable "forward_rg_name" {
  description = "The name of the resource group to deploy in."
}

variable "reverse_rg_name" {
  description = "The name of the resource group to deploy in."
}

# Peering Variables
variable "source_vnet_name" {
  description = "The name of the hub vnet."
}

variable "source_vnet_id" {
  description = "The id of the hub vnet"
}

# Peering Variables
variable "remote_vnet_name" {
  description = "The name of the hub vnet."
}

variable "remote_vnet_id" {
  description = "The name of the spoke vnet."
}