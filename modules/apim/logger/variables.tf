# Global Vars
variable "environment" {
  description = "The environment that the resources are deployed for."
  default     = "dev"
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

# Logger Variables
variable "apim_name" {
  description = "The name of the API Management instance to target."
}
variable "instrumentation_key" {
  description = "The instrumentation key from the application insights instance for logging."
  default = null
}
variable "evh_name" {
  description = "The name of the Event Hub instance to target."
  default = null
}
variable "evh_connection_string" {
  description = "The connection string for the Event Hub instance."
  default = null
}
