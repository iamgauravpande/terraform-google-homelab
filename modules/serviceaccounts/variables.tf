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