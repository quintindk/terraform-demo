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