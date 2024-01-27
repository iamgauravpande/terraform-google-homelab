### Creation of GCE Disk:

-  To create one or more Disk using a public gcp Ubuntu based image : 

`entrypoint.tf` would reference computedisk module under `modules` directory

```hcl
module "computedisk" {
  source  = "iamgauravpande/homelab/google//modules/computedisk"
  disk = var.disk
}
```

`main.tf` would contain the code to create a disk resource:

```hcl
resource "google_compute_disk" "disk" {
    for_each = var.disk
    name = each.value["name"]
    type = each.value["type"]
    zone = each.value["zone"]
    image = each.value["image"]
    size = each.value["disk_size"]
    labels = each.value["labels"]
}
```

`terraform.tfvars` example can be like :

```hcl
disk = {
  "disk01" = {
    name = "disk01"
    type = "pd-ssd"
    zone = "asia-south2-a"
    image = "ubuntu-minimal-2204-jammy-v20240119"
    labels = {
      environment = "homelab"
      app = "vm01"
    }
    disk_size = 10
  }
  "disk02" = {
    name = "disk02"
    type = "pd-ssd"
    zone = "asia-south2-b"
    image = "ubuntu-minimal-2204-jammy-v20240119"
    labels = {
      environment = "homelab"
      app = "vm02"
    }
    disk_size = 10
  }
}
```