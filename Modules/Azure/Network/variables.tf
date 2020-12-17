################### firewall vars ######################
variable "pubipname" {
    description = "Provide a name for the public IP"
}
variable "location" {
    description = "Location where resources are created"
}
variable "resource_group_name" {
    description = "Resource group name where resource will be created in"
}
variable "firewallname" {
    description = "Provide a name for the Firewall"
}
variable "azurerm_subnet_id" {
    description = "Provide the subnet_id"
}

# TAGS
variable "created_on" {
    default     = ""
}

variable "tags" {
    description     = "Description of tags"
    type            = map(string)
}
########################################################



################# nsg vars #############################
output "name" {
  value = azurerm_network_security_group.nsg.name
}
output "id" {
  value = azurerm_network_security_group.nsg.id
}
########################################################



##################### resource group vars ###################
variable "base_name" {
  description = "The base name to use for all resources."
}
############################################################



#################### subnets vars ###########################
variable "region" {
  description = "The region to deploy the resources in."
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
#####################################################################



########################## vnet #####################################

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
##########################################################################


########################### vnet peering ##################################
variable "hubvnetname" {
  description = "The name of the hub vnet."
}

variable "spokevnetname" {
  description = "The name of the spoke vnet."
}

variable "rg_name" {
  description = "The name of the resource group to deploy in."
}

variable "hubvnet_id" {
  description = "The name of the hub vnet."
}

variable "spokevnet_id" {
  description = "The name of the spoke vnet."
}

############################################################################



######################## vpn gateway ########################################
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
#################################################################