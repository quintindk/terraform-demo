VNET
====

Simple helper module to create virtual networks with the correct naming
convention and tags.

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

### tags

- __description__: Additional tags to add to the deployed resources.
- __default__: null

### address_spaces

- __description__: An array of address spaces to use in this VNET instance.
- __default__: null

### dns_servers

- __description__: An array of DNS servers to use in the VNET.
- __default__: null

### subnets

- __description__: An array of subnets to configure on the VNET instance. See documentation for more information.
- __default__: null

#### Structure

This variable makes use of the following structure. (Items marked with "*" are required)

```
[{
    name              = string*
    address_prefix    = string*
    security_group_id = bool
}]
```

- name: The name of the subnet.
- address_prefix: The address prefix to use for the subnet.
- security_group_id: The ID of the network security group to use on the subnet.

## Usage

```
module "vnet" {
  source = "../modules/vnet"

  region      = "southafricanorth"
  environment = "dev"
  base_name   = "ilikepie"
  
  address_space = ["10.0.0.0/16"]
  dns_servers   = ["10.0.0.4", "10.0.0.5"]
  subnets       = [{
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }]
}
```

## Outputs

The module provides the following output:

- __name__: The name of the virtual network.

## Naming

This module uses the standard naming convention by prefix the resource type
to the environment and base name.

The following config will generate the name __vnetdevilikepie__:

```
region      = "southafricanorth"
environment = "dev"
base_name   = "ilikepie"
```