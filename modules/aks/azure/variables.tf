# Global Vars
variable "region" {
  description = "The region to deploy the resources in."
  default     = "southafricanorth"
}
variable "environment" {
  description = "The environment that the resources are deployed for."
  default     = ""
}
variable "base_name" {
  description = "The base name to use for all resources."
  default     = ""
}
variable "tags" {
  description = "The tags to add to the deployed resources."
  default     = {}
}

# Resource Group
variable "rg_name" {
  description = "The name of the resource group to deploy in."
}

variable "default_node_pool_name" {
  description = "The name of the default node pool as defined in the node_pools variable. See documentation for more information."
  default = "nodepool"
}
variable "node_pools" {
  description = "A map containing the definition for node pools in the cluster. See documentation for more information."
  default     = {}
  type        = map(object({
    size           = string
    count          = number
    min_count      = number
    max_count      = number
    auto_scaling   = bool
    max_pods       = number
    node_taints    = list(string)
    disk_size      = number
    vnet_subnet_id = string
  }))
}
variable "rbac_enabled" {
  description = "Whether to enable RBAC on Kubernetes or not."
  default     = true
  type        = bool
}
variable "dns_service_ip" {
  description = "The IP address within the Kubernetes service address range that will be used for DNS."
  default     = "172.28.32.10"
  type        = string
}
variable "docker_bridge_cidr" {
  description = "IP address (in CIDR notation) used as the Docker bridge IP address on nodes."
  default     = "10.0.0.1/16"
  type        = string
}
variable "service_cidr" {
  description = "The network range used by the Kubernetes service."
  default     = "172.28.32.0/24"
  type        = string
}
variable "identity_type" {
  description = "This is the Type of identity i.e. UserAssigned / SystemAssigned"
  default = "SystemAssigned"
}
variable "user_assigned_ids" {
  type = string
  description = "The principal id of the user assigned ID"
  default = null
}
variable "log_analytics_workspace_id" {
  description = "The ID of an existing log analytics workspace"
  default = null
}
