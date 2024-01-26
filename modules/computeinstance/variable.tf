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