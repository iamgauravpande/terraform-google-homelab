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