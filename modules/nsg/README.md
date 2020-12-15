NSG
===

Simple helper module to create network security groups with the correct naming
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

### security_rules

- __description__: An array of address spaces to use in this VNET instance.
- __default__: null

#### structure

This variable makes use of the following structure. (Items marked with "*" are required)

```
[{
    name                         = string*
    protocol                     = string*
    access                       = string*
    priority                     = number*
    direction                    = string*
    source_port_ranges           = list(string)*
    destination_port_ranges      = list(string)*
    source_address_prefixes      = list(string)*
    destination_address_prefixes = list(string)*
}]
```

- name: The name of the security rule.
- protocol: The protocol targeted by the security rule. Allowed Values: ["Tcp", "Udp", "Icmp", "*"]
- access: Whether to allow or deny the connection. Allowed Values: ["Allow", "Deny"]
- priority: The priority of the rule. The lower the number the higher the priority of the rule.
- direction: The direction of the network traffic targeted by the security rule. Allowed Values: ["Inbound", "Outbound"]
- source_port_ranges: Array of source ports to target.
- destination_port_ranges: Array of destination ports to target.
- source_address_prefixes: Array of source address prefixes to target.
- destination_address_prefixes: Array of destination address prefixes to target.

## Usage

```
module "nsg" {
  source = "../modules/nsg"

  region      = "southafricanorth"
  environment = "dev"
  base_name   = "ilikepie"
  rg_name     = module.rg.name

  security_rules = [{
    name                         = "testSecurityRule"
    priority                     = 100
    direction                    = "Inbound"
    access                       = "Deny"
    protocol                     = "Tcp"
    source_port_ranges           = ["*"]
    destination_port_ranges      = ["22"]
    source_address_prefixes      = ["*"]
    destination_address_prefixes = ["*"]
  }]
}
```

## Outputs

The module provides the following output:

- __name__: The name of the network security group.
- __id__: The ID of the network security group.

## Naming

This module uses the standard naming convention by prefix the resource type
to the environment and base name.

The following config will generate the name __nsgdevilikepie__:

```
region      = "southafricanorth"
environment = "dev"
base_name   = "ilikepie"
```