resource "google_compute_instance" "instance" {
    
    for_each = var.computeinstance
    name = each.value["name"]
    machine_type = each.value["machine_type"]
    zone = each.value["zone"]
    allow_stopping_for_update = each.value["allow_stopping_for_update"]
    
    network_interface {
      subnetwork = each.value["subnetwork"]
    }
    
    boot_disk {
      source = each.value["boot_disk_source"]
      auto_delete = each.value["boot_disk_auto_delete"]
      mode = each.value["boot_disk_mode"]
    }
    service_account {
      email = each.value["service_account_email"]
      scopes = each.value["service_account_scopes"]
    }
    
}