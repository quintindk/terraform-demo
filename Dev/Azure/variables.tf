########################### Global ##############################
variable "global_tags" {
  description = "All Cloud network global tags for Terraform Project"
  type = map(string)
  default = {
    "Author" = "Leon Mwandiringa",
    "Environment" = "Development",
    "Project" = "Terraform Project",
    "Stage" = "Dev"
  }
}
variable "region" {
  default = "westeurope"
}
#################################################################