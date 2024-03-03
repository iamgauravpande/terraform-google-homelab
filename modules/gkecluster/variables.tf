variable "gkecluster" {
    type = map(object({
      name = string
      location = string
      remove_default_node_pool = bool
      initial_node_count = number
      deletion_protection = bool
      networking_mode = string
      release_channel = string
      min_master_version = string
      network = string
      subnetwork = string
      cluster_secondary_range_name = string
      services_secondary_range_name = string
      stack_type = string 
      enable_private_nodes = bool
      master_ipv4_cidr_block    = string

    }))
  
}