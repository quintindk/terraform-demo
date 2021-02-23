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

# Local Vars
locals {
  base_name        = "demo"
  region           = "westeurope"
}

resource "azurerm_security_center_subscription_pricing" "security_centre" {
  tier = "Free"
}

module "rg_shared" {
    source = "../modules/resource_group"
    
    region      = var.region
    base_name   = "shared"
    environment = local.environment
    tags        = local.tags
}

module "rg_network" {
    source = "../modules/rg"
    
    region      = var.region
    base_name   = "network"
    environment = local.environment
    tags        = local.tags
}