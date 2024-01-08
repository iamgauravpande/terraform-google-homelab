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