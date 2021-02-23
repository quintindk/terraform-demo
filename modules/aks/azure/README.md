AKS_Azure
=========

A module to create an AKS cluster.

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

### identity_type

- __description__: The Type of identity to be used i.e. UserAssigned / SystemAssigned
- __default__: null

### user_assigned_ids

- __description__: The principal id of the specified user assigned ID
- __default__: null

### node_pools

- __description__: An array containing the definition for node pools in the cluster.
- __default__: []

#### Structure

This variable makes use of the following structure. (Items marked with "*" are required)

```
[{
    name           = string*
    size           = string*
    count          = number
    min_count      = number
    max_count      = number
    auto_scaling   = bool
    max_pods       = number
    node_taints    = list(string)
    disk_size      = number
    vnet_subnet_id = string
}]
```

- name: The name of the node pool
- size: The VM size to use for this node pool.
- count: The amount of VMs in the node pool.
- min_count: The minimum amount of VMs to scale down to if auto scaling is enabled.
- max_count: The maximum amount of VMs to scale down to if auto scaling is enabled.
- auto_scaling: Whether to enable auto scaling or not.
- max_pods: The maximum amount of pods to use per node.
- node_taints: An array of taints on the nodes in the node pool.
- disk_size: The size of the OS disk in GB.
- vnet_subnet_id: The ID of the subnet to deploy the nodes in.

### rbac_enabled

- __description__: Whether to enable RBAC on Kubernetes or not.
- __default__: "true"

### dns_service_ip

- __description__: The IP address within the Kubernetes service address range that will be used for DNS.
- __default__: "172.28.32.10"

### docker_bridge_cidr

- __description__: IP address (in CIDR notation) used as the Docker bridge IP address on nodes.
- __default__: "10.0.0.1/16"

### pod_cidr

- __description__: The CIDR to use for pod IP addresses.
- __default__: "10.240.0.0/16"
  
### service_cidr

- __description__: The network range used by the Kubernetes service.
- __default__: "172.28.32.0/24"

## Usage

```
module "aks_kubenet" {
  source = "../modules/aks/kubenet"

  region                   = "southafricanorth"
  environment              = "dev"
  base_name                = "ilikepie"
  rg_name                  = module.rg.name
  service_principal_id     = "..."
  service_principal_secret = "..."

  node_pools = [{
    name           = "default"
    size           = "Standard_D2s_v3"
    vnet_subnet_id = module.subnet.id
  }]

  dns_service_ip     = "172.28.32.10"
  docker_bridge_cidr = "10.0.0.1/16"
  pod_cidr           = "10.240.0.0/16"
  service_cidr       = "172.28.32.0/24"
}
```

## Outputs

The module provides the following output:

- __client_certificate__: The base64 encoded client certificate of the new cluster.
- __client_key__: The base64 encoded client key of the new cluster.
- __cluster_ca_certificate__: The base64 encoded cluster CA certificate of the new cluster.
- __host__: The host of the new cluster.
- __kube_config__: The raw kubeconfig of the new cluster.
- __name__: The name of the Managed Kubernetes Cluster to create.


## Naming

This module uses the standard naming convention by prefix the resource type
to the environment and base name.

The following config will generate the name __aksdevilikepie__:

```
region      = "southafricanorth"
environment = "dev"
base_name   = "ilikepie"
```