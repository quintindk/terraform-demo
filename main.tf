/**
 * # Deploy the Tangent Demo infrastructure.
 *
 * TODO:
 *
 * - [x] Add modules to main.tf
 * - [x] Add Azure Firewall module
 * - [ ] Add firewall rules
 * - [x] Add AKS
 * - [x] Add API management
 * - [x] Add App Insights module
 * - [x] Add API management logger
 * - [x] Add Azure SQL module
 *
 * - [ ] Update the docs
 *
 * - [ ] Add github actions file.
 *
 */

terraform {
  required_providers {
    azurerm = {
      source  = "azurerm"
      version = "=2.50.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Local Vars
locals {
  base_name = "demo"
}

resource "azurerm_security_center_subscription_pricing" "security_centre" {
  tier = "Free"
}

# Shared resource group.
module "rg_shared" {
  source = "./modules/rg"

  region      = var.region
  base_name   = "shared"
  environment = var.environment
  tags        = var.tags
}

# Network resource group.
module "rg_network" {
  source = "./modules/rg"

  region      = var.region
  base_name   = "network"
  environment = var.environment
  tags        = var.tags
}

# Virtual network for the Kubernetes cluster.
module "vnet" {
  source = "./modules/vnet/vnet"

  region      = var.region
  base_name   = local.base_name
  environment = var.environment

  rg_name = module.rg_network.name

  address_spaces = ["10.0.0.0/16"]

  tags = var.tags
}

# Network Security Group for the AKS network.
module "nsg" {
  source = "./modules/nsg"

  region      = var.region
  environment = var.environment
  base_name   = local.base_name
  rg_name     = module.rg_network.name

  security_rules = [{
    name                         = "${module.vnet.name}-nsg"
    priority                     = 100
    direction                    = "inbound"
    access                       = "Deny"
    protocol                     = "Tcp"
    source_port_ranges           = ["*"]
    destination_port_ranges      = ["22", "80", "443"]
    source_address_prefixes      = ["*"]
    destination_address_prefixes = ["*"]
  }]
}

# Subnet for the AKS cluster.
module "subnet" {
  source = "./modules/vnet/subnet_nsg"

  base_name        = local.base_name
  environment      = var.environment
  rg_name          = module.rg_network.name
  vnet_name        = module.vnet.name
  address_prefixes = ["10.0.1.0/24"]

  nsg_id = module.nsg.id
}

# Firewall VNET.
module "fw_vnet" {
  source = "./modules/vnet/vnet"

  region      = var.region
  base_name   = local.base_name
  environment = var.environment

  rg_name = module.rg_network.name

  address_spaces = ["10.1.0.0/16"]

  tags = var.tags
}

# Azure Firewall.
module "fw" {
  source = "./modules/afw/fw"

  base_name        = local.base_name
  environment      = var.environment
  rg_name          = module.rg_network.name
  vnet_name        = module.fw_vnet.name
  address_prefixes = ["10.1.1.0/24"]
}

# Network peering for the AKS and Firewall networks.
module "peering" {
  source = "./modules/vnet/peering"

  source_vnet_name = module.vnet.name
  remote_vnet_name = module.fw_vnet.name
  source_vnet_id   = module.vnet.id
  remote_vnet_id   = module.fw_vnet.id
  forward_rg_name  = module.rg_network.name
  reverse_rg_name  = module.rg_network.name
}

# Azure Kubernetes Service cluster.
module "aks" {
  source = "./modules/aks/azure"

  base_name   = local.base_name
  environment = var.environment
  region      = var.region
  rg_name     = module.rg_network.name

  node_pools = {
    nodepool = {
      size           = "Standard_D2s_v3"
      count          = 3
      min_count      = 3
      max_count      = 10
      auto_scaling   = true
      max_pods       = 15
      node_taints    = null
      disk_size      = 30
      vnet_subnet_id = module.subnet.id
  } }
}

# Azure Container Registry.
module "acr" {
  source = "./modules/acr"

  base_name   = local.base_name
  environment = var.environment
  region      = var.region
  rg_name     = module.rg_shared.name
  sku         = "Standard"
  tags        = var.tags

}

# Azure API Management.
module "apim" {
  source = "./modules/apim/apim"

  base_name   = local.base_name
  environment = var.environment
  region      = var.region
  rg_name     = module.rg_shared.name
}

# Applications Insights.
module "ai" {
  source = "./modules/ai"

  base_name   = local.base_name
  environment = var.environment
  region      = var.region
  rg_name     = module.rg_shared.name
}

# Azure API Management Logger.
module "logger" {
  source = "./modules/apim/logger"

  apim_name           = module.apim.name
  base_name           = local.base_name
  environment         = var.environment
  rg_name             = module.rg_shared.name
  instrumentation_key = module.ai.instrumentation_key
}

# Key Vault
module "kv" {
  source = "./modules/kv"

  base_name   = local.base_name
  environment = var.environment
  region      = var.region
  rg_name     = module.rg_shared.name

  access_policies = {
    access_policy = {
      certificate_permissions = []
      key_permissions         = ["Get", "Create"]
      secret_permissions      = ["Get", "Set"]
      storage_permissions     = ["Get", "Set"]
    }
  }
}

# Azure SQL
module "sql" {
  source = "./modules/sql"

  base_name    = local.base_name
  environment  = var.environment
  region       = var.region
  rg_name      = module.rg_shared.name
  key_vault_id = module.kv.id
}
