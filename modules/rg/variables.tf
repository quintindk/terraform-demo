# Global Variables
variable "region" {
  description = "The region to deploy the resources in."
}
variable "environment" {
  description = "The environment that the resources are deployed for."
}
variable "base_name" {
  description = "The base name to use for all resources."
}
variable "tags" {
  description = "The tags to add to the deployed resources."
  default     = {}
}