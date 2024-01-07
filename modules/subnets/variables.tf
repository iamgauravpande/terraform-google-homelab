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