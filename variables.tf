variable "network_name" {
  description = "The Name of the network"
  type        = list(string)
}

variable "auto_create_subnetworks" {
  description = "When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources"
  type        = bool
  default     = false
}
variable "subnets" {
    type = map(object({
        name = string
        region = string
        ip_cidr_range = string
        vpc_network = string
        private_ip_access = bool
        stack_type = string
    }))
}
variable "secondary_ranges" {
    type = map(list(object({
        range_name = string
        secondary_ip_cidr_range = string
    })))
    default = {}
}

variable "buckets" {
    type = map(object({
      name = string
      location = string
      force_destroy = optional(bool,true)
      storage_class = optional(string,"ARCHIVE")
      uniform_bucket_level_access = optional(bool,true)
      public_access_prevention = optional(string,"enforced")
    }))
}

variable "serviceaccount" {
    type = map(object({
      account_id = string
      display_name = optional(string)
      description = optional(string)
      disabled = optional(bool, false)
    }))
}
variable "bindings" {
  type = map(list(string))
}
variable "project" {
  type = string
  
}
variable "serviceaccount_key" {
  type = list(string)
}

variable "disk" {
    type = map(object({
      name = string
      type = string
      zone = string
      image = string
      labels = optional(map(string))
      disk_size = number
    }))
}

variable "computeinstance" {
    type = map(object({
      name = string
      machine_type = string
      zone = string
      subnetwork = string 
      boot_disk_source = string 
      boot_disk_auto_delete = bool 
      boot_disk_mode = string
      service_account_email = string
      service_account_scopes = list(string)
      allow_stopping_for_update = bool
    }))
}
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