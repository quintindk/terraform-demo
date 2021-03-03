/**
 * # Deploy the Tangent Demo infrastructure.
 *
 * TODO:
 *
 * - [ ] Add modules to main.tf
 * - [x] Add Azure Firewall module
 * - [ ] Add Azure Monitor module
 *        What should we monitor?
 * - [ ] Add Azure SQL module
 *
 * - [ ] Add github actions file.
 *
 */

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
  base_name = "demo"
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

module "vnet" {
  source = "./modules/vnet/vnet"

  region      = var.region
  base_name   = local.base_name
  environment = var.environment

  rg_name = module.rg_network.name

  address_spaces = ["10.0.0.0/16"]

  tags = var.tags
}

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

module "subnet" {
  source = "./modules/vnet/subnet_nsg"

  base_name = local.base_name
  environment = var.environment
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

module "fw" {
  source = "./modules/afw"

  base_name = local.base_name
  environment = var.environment
  rg_name = module.rg_network.name
  vnet_name = module.fw_vnet.name
  address_prefixes = ["10.1.1.0/24"] 
}

module "peering" {
  source = "./modules/vnet/peering"

  source_vnet_name = module.vnet.name
  remote_vnet_name = module.fw_vnet.name
  source_vnet_id = module.vnet.id
  remote_vnet_id = module.fw_vnet.id
  forward_rg_name = module.rg_network.name
  reverse_rg_name = module.rg_network.name
}
