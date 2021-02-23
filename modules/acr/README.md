Azure Container Registry
===========================

A module to create an Azure Container Registry.

## Variables

The following variables are available:

### region

- __description__: The region to deploy the resources in.
- __default__: "southafricanorth"

### environment

- __description__: The environment that the resources are deployed for.
- __default__: "dev"

### base_name

- __description__: The base name to use for all resources.
- __default__: ""

### rg_name

- __description__: The name of the resource group to deploy in.
- __default__: null

### tags

- __description__: Additional tags to add to the deployed resources.
- __default__: null

### admin

- __description__: Whether to enable admin access or not.
- __default__: null

### sku

- __description__: Which SKU to use for the ACR.
- __default__: null

## Usage

```
module "acr" {
  source = "../modules/acr"

  region                   = "southafricanorth"
  environment              = "dev"
  base_name                = "ilikepie"
  rg_name                  = module.rg.name
  admin                    = false
  sku                      = "Standard"
}
```

## Outputs

The module provides the following output:

- __id__: The ID of the resource.
- __login_server__: The login server for the created ACR.

## Naming

This module uses the standard naming convention by prefix the resource type
to the environment and base name.

The following config will generate the name __acrdevilikepie__:

```
region      = "southafricanorth"
environment = "dev"
base_name   = "ilikepie"
```