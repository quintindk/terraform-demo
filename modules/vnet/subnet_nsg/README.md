SUBNET
======

Simple helper module to create virtual network subnets.

## Variables

The following variables are available:

### rg_name

- __description__: The name of the resource group to deploy in.
- __default__: null

### address_spaces

- __description__: An array of address spaces to use in this VNET instance.
- __default__: null

### name

- __description__: The name of the subnet.

### vnet_name

- __description__: The name of the VNET to create the subnet in.

### address_prefix

- __description__: The address prefix to use for the subnet.

### nsg_id

- __description__: The ID of a network security group to associate to this subnet.

## Usage

```
module "subnet" {
  source = "../modules/vnet/subnet"

  region      = "southafricanorth"
  environment = "dev"
  base_name   = "ilikepie"
  
  name           = "default"
  vnet_name      = module.vnet.name
  address_prefix = "10.240.0.0/16"
  nsg_id         = module.nsg.id
}
```

## Outputs

The module provides the following output:

- __name__: The name of the virtual network subnet.
- __id__: The ID of the virtual network subnet.