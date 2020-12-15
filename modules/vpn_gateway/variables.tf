variable "vwan_name" {
    description = "Add a name for the virtual wan"
}

variable "vhub_name" {
    description = "Add a name for the virutal hub"
}

variable "vpngw_name" {
    description = "Add a name for the vpn gateway"
}

variable "location" {
  description = "The region to deploy the resources in"
}

variable "rg_name" {
  description = "The name of the resource group to deploy in."
}

variable "address_prefix" {
    description = "Add the address prefix"
}

variable "env" {
    description = "Environment"
}

# TAGS
variable "created_on" {
    default     = ""
}

variable "tags" {
    description     = "Description of tags"
    type            = map
}

variable "vpnpip_name" {
    description = "The name of the Public IP resource"
}

variable "vnetgw_name" {
    description = "The name of the Virtual Netowrk Gateway resource"
}

variable "address_space" {
    description = "Virtual Network Gateway address space"
}

variable "vnet_subnet_id" {
    type = string
    description = "This is the ID of the GatewaySubnet"
}