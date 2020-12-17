variable "service_principal_id" {}
variable "service_principal_secret" {}

terraform {
  required_providers {
    azurerm = {
      source  = "azurerm"
      version = "=2.20.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_security_center_subscription_pricing" "security_centre" {
  tier = "Free"
}

module "rg_shared" {
    source = "../modules/resource_group"
    
    region      = var.region
    base_name   = "shared"
    tags        = var.global_tags
}

module "rg_network" {
    source = "../modules/rg"
    
    region      = var.region
    base_name   = "network"
    tags        = var.global_tags
}