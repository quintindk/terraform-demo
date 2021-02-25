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
  environment      = "demo"
  tags             = {
        base_name   = "demo"
        environment = "demo"
  }
}

resource "azurerm_security_center_subscription_pricing" "security_centre" {
  tier = "Free"
}

module "rg_shared" {
    source = "./modules/rg"
    
    region      = local.region
    base_name   = "shared"
    environment = local.environment
}

module "rg_network" {
    source = "./modules/rg"
    
    region      = local.region
    base_name   = "network"
    environment = local.environment
}


module "acr" {
    source = "./modules/acr"

    region      = local.region
    environment = local.environment
    base_name   = local.base_name
    rg_name     = module.rg_shared.name
    admin       = "true"
    sku         = "Standard"
}

module "kv" {
  source = "./modules/kv"
  

  base_name     = local.base_name
  region        = local.region
  rg_name     = module.rg_shared.name
  environment   = local.environment

  access_policies = {
    policies = {
      certificate_permissions  = ["get", "import", "list", "create"]
      key_permissions          = ["get", "create"]
      secret_permissions       = ["get", "set"]
      storage_permissions      = ["backup", "get", "list", "recover"]
  }}
  
}

module "vnet" {
  source = "./modules/vnet/vnet"

  region           = local.region
  environment      = local.environment
  base_name        = local.base_name
  rg_name          = module.rg_network.name
  address_spaces   = ["10.0.0.0/16"]
  
}


module "apim" {
  source = "./modules/apim/apim"
  
  region           = local.region
  environment      = local.environment
  base_name        = local.base_name
  rg_name          = module.rg_shared.name

}

module "aks" {
  source = "./modules/aks/azure"
  
  region           = local.region
  environment      = local.environment
  base_name        = local.base_name
  rg_name          = module.rg_shared.name

  node_pools ={
    nodepool ={
    size           = "Standard_D2s_v3"
    count          = 1
    min_count      = 1
    max_count      = 3
    auto_scaling   = "true"
    max_pods       = 10
    node_taints    = null
    disk_size      = 8
    vnet_subnet_id = module.vnet.id
    } 
  }
}

module "nsg" {
  source = "./modules/nsg"

  region           = local.region
  environment      = local.environment
  base_name        = local.base_name
  rg_name          = module.rg_network.name

  security_rules = [{
        name                         = "${local.base_name}-nsg"
        priority                     = "100"
        direction                    = "Outbound"
        access                       = "Allow"
        protocol                     = "*"
        source_port_ranges           = ["*"]
        destination_port_ranges      = ["*"]
        source_address_prefixes      = ["*"]
        destination_address_prefixes = ["*"]
  }]
  
}

module "appinsights" {
  source = "./modules/app-insights"
  
  region             = local.region
  environment        = local.environment
  base_name          = local.base_name
  rg_name            = module.rg_shared.name
  app_type   = "other"
}

module "logger" {
  source = "./modules/apim/logger"
  
  environment           = local.environment
  base_name             = local.base_name
  rg_name               = module.rg_shared.name
  apim_name             = module.apim.name
  instrumentation_key   = module.appinsights.instrumentation_key

}