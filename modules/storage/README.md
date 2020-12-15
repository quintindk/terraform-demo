STORAGE
=======

Simple helper module to create storage accounts.

## Variables

The following variables are available:

### rg_name

- __description__: The name of the resource group to deploy in.
- __default__: null

### type

- __description__: The type of storage account to create.
- __default__: "StorageV2"

#### Available Values

The following values are available:

- BlobStorage
- BlockBlobStorage
- FileStorage
- Storage
- StorageV2

### tier

- __description__: The tier to use for this storage account.
- __default__: "Standard"

#### Available Values

The following values are available:

- Standard
- Premium

> *FileStorage* only allows *Premium* tier.

### replication

- __description__: The type of replication to use for this storage account.
- __default__: "LRS"

#### Available Values

The following value are available:

- LRS
- GRS
- RAGRS
- ZRS

### access_tier

- __description__: The access the tier to use for this storage account.
- __default__: null

#### Available Values

The following values are available:

- Hot
- Cool

> This value defaults to *Hot*

### blob_encryption

- __description__: Whether to enable encryption on blobs or not.
- __default__: true

### file_encryption

- __description__: Whether to enable encryption on files or not.
- __default__: true

### https_only

- __description__: Whether to limit all traffic to HTTPS or not.
- __default__: true

### network_rules

- __description__: An array of network rules for this blob instance. See documentation for more information.
- __default__: []

#### Structure

This variable makes use of the following structure. (Items marked with "*" are required)

```
[{
    action     = string
    ip_rules   = list(string)
    subnet_ids = list(string)
}]
```

- action: Whether to allow or deny the request. Available Values: ["Allow", "Deny"]
- ip_rules: The list of public IPs or IP ranges in CIDR format to target.
- subnet_ids: A list of subnet IDs.

## Usage

```
module "subnet" {
  source = "../modules/vnet/subnet"

  region      = "southafricanorth"
  environment = "dev"
  base_name   = "ilikepie"
  
  type            = "StorageV2"
  tier            = "Standard"
  replication     = "LRS"
  access_tier     = "HOT"
  blob_encryption = true
  file_encryption = true
  https_only      = true
  
  network_rules = [{
    action     = "Allow"
    ip_rules   = ["100.0.0.1"]
    subnet_ids = [module.subnet.id]
  }]
}
```

## Outputs

The module provides the following output:

- __name__: The name of the storage account.
- __id__: The ID of the storage account.

## Naming

This module uses the standard naming convention by prefix the resource type
to the environment and base name.

The following config will generate the name __stordevilikepie__:

```
region      = "southafricanorth"
environment = "dev"
base_name   = "ilikepie"
```