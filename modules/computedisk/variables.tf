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