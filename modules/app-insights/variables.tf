variable "base_name" {
    description = "Provide the name for the Azure Key Vault"
}
variable "region" {
    description = "Provide location for resource to be created in"
}
variable "rg_name" {
    description = "Provide the resource group name"
}
variable "environment" {
    description = "Environment"
}

variable "app_type" {
    description = "Specifies the type of Application Insights to create"
}

variable "tags" {
    description     = "Description of tags"
    default     = {}
}