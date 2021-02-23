resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-${var.base_name}-${var.environment}"
  location            = var.region
  resource_group_name = var.rg_name
  dns_prefix          = "aks-${var.base_name}-${var.environment}"

  identity {
    type                        = var.identity_type
    user_assigned_identity_id   = var.user_assigned_ids 
  }

  addon_profile {
    azure_policy {
      enabled = true
    }
    oms_agent {
      enabled = true
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }

  default_node_pool {
    name                = var.default_node_pool_name
    vm_size             = var.node_pools[var.default_node_pool_name].size
    node_count          = var.node_pools[var.default_node_pool_name].count
    min_count           = var.node_pools[var.default_node_pool_name].min_count
    max_count           = var.node_pools[var.default_node_pool_name].max_count
    enable_auto_scaling = var.node_pools[var.default_node_pool_name].auto_scaling
    max_pods            = var.node_pools[var.default_node_pool_name].max_pods
    node_taints         = var.node_pools[var.default_node_pool_name].node_taints
    os_disk_size_gb     = var.node_pools[var.default_node_pool_name].disk_size
    vnet_subnet_id      = var.node_pools[var.default_node_pool_name].vnet_subnet_id
    type                = var.node_pools[var.default_node_pool_name].auto_scaling == true ? "VirtualMachineScaleSets" : "AvailabilitySet"
  }

  role_based_access_control {
    enabled = var.rbac_enabled
  }

  network_profile {
    network_plugin     = "azure"
    network_policy     = "azure"
    dns_service_ip     = var.dns_service_ip
    docker_bridge_cidr = var.docker_bridge_cidr
    service_cidr       = var.service_cidr
  }

  # Add this else the resource will be constantly be recreated
  lifecycle {
    ignore_changes = [
      windows_profile,
      default_node_pool[0].node_count
    ]
  }


  tags = merge({
    Environment = var.environment
    Base        = var.base_name
  }, var.tags)
}

resource "azurerm_kubernetes_cluster_node_pool" "aks-pools" {
  for_each = {
    for key, value in var.node_pools : key => value if key != var.default_node_pool_name
  }

  name                  = each.key
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = each.value.size
  node_count            = each.value.count
  enable_auto_scaling   = each.value.auto_scaling
  min_count             = each.value.min_count
  max_count             = each.value.max_count
  max_pods              = each.value.max_pods
  node_taints           = each.value.node_taints
  os_disk_size_gb       = each.value.disk_size
  vnet_subnet_id        = each.value.vnet_subnet_id
}
