# Global Variables
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
variable "tags" {
    description     = "Description of tags"
    type            = map
}

variable "access_policies" {
    description     = "The list of managed identiteis"
    type            = map(object({
        object_id               = string
        certificate_permissions = list(string)
        key_permissions         = list(string)
        secret_permissions      = list(string)
        storage_permissions     = list(string)
    }))
}