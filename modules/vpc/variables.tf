variable "network_name" {
    description = "The Name of the network"
    type = string
}

variable "auto_create_subnetworks" {
    description = "When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources"
    type = bool
    default = false
}