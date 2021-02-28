variable "region" {
  description = "The region where resources will be deployed."
  type = string
}

variable "environment" {
  description = "The environment where resources are deployed."
  type = string
}

variable "tags" {
  description = "Tags to associate with Azure resource groups."
  type = map(string)
  default {}
}
