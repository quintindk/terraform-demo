# Global Vars
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

variable "tier" {
  description = "database tier"
  default = "Standard"
}

variable "replication_type" {
  description = "replication type"
  default = "LRS"
}

variable "db_version" {
  description = "database version"
  default = "12.0"
}


variable "admin_login" {
  description = "db admin login"
  default = "dbadmin"
}


variable "admin_pass" {
  description = "db admin pass"
}

