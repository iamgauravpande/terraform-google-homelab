### Creation of GCE VM:

-  To create one or more VM : 

`entrypoint.tf` would reference computeinstance module under `modules` directory

```hcl
module "computeinstance" {
  source = "iamgauravpande/homelab/google//modules/computeinstance"
  computeinstance = var.computeinstance
  depends_on = [ 
    module.vpc,
    module.subnets,
    module.computedisk,
    module.serviceaccounts
  ]
}
```

`main.tf` would contain the code to create a compute instance resource:

```hcl
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
```

`terraform.tfvars` example can be like :

```hcl
computeinstance = {
  "instance01" = {
    name = "instance01"
    machine_type = "e2-micro"
    zone = "asia-south2-a"
    subnetwork = "subnet01"
    boot_disk_source = "disk01"
    boot_disk_auto_delete = "false"
    boot_disk_mode = "READ_WRITE"
    service_account_email = "compute@bitlost.iam.gserviceaccount.com"
    service_account_scopes = ["cloud-platform"]
    allow_stopping_for_update = "true"
  }

  "instance02" = {
    name = "instance02"
    machine_type = "e2-micro"
    zone = "asia-south2-b"
    subnetwork = "subnet02"
    boot_disk_source = "disk02"
    boot_disk_auto_delete = "false"
    boot_disk_mode = "READ_WRITE"
    service_account_email = "compute@bitlost.iam.gserviceaccount.com"
    service_account_scopes = ["cloud-platform"]
    allow_stopping_for_update = "true"
  }

}
```