Key Vault
=========

A module to create an Azure Key Vault for securely storing and accessing secrets.

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

### access_policies

- __description__: List of managed identiteis
- __default__: []

#### Structure

This variable makes use of the following structure. (Items marked with "*" are required)

```
[{
    object_id               = string
    certificate_permissions = list(string)
    key_permissions         = list(string)
    secret_permissions      = list(string)
    storage_permissions     = list(string)
}]
```

- object_id: The object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault
- certificate_permissions: List of certificate permissions.
- key_permissions: List of key permissions.
- secret_permissions: List of secret permissions.
- storage_permissions: List of storage permissions.

## Outputs

The module provides the following output:

- __id__: The ID of the Key Vault.
- __uri__: The URI of the Key Vault, used for performing operations on keys and secrets.
