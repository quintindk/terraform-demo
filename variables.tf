variable "region" {
  description = "The region where resources will be deployed."
  type        = string
  default = "westeurope"
}

variable "environment" {
  description = "The environment where resources are deployed."
  type        = string
  default = "development"
}

variable "tags" {
  description = "Tags to associate with Azure resource groups."
  type        = map(string)
  default {}
}
