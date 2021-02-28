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
}

resource "azurerm_security_center_subscription_pricing" "security_centre" {
  tier = "Free"
}

module "rg_shared" {
    source = "./modules/rg"
    
    region      = var.region
    base_name   = "shared"
    environment = var.environment
    tags        = var.tags
}

module "rg_network" {
    source = "./modules/rg"
    
    region      = var.region
    base_name   = "network"
    environment = var.environment
    tags        = var.tags
}
