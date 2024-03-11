variable "nodepool" {
    type = map(object({
      name = string
      cluster = string
      location = string
      node_count = number
      max_pods_per_node = number
      version = string
      node_config-disk_size_gb = number
      node_config-disk_type = string
      node_config-spot_instance = bool
      node_config-image_type = string
      node_config-machine_type = string
      node_config-service_account = string
      node_config-oauth_scopes = list(string)
      network_config-create_pod_range = bool 
      network_config-enable_private_nodes = bool
      network_config-pod_range = string
    }))
  
}