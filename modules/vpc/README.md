### Creation of VPC:

-  To create one or more VPC : 

`entrypoint.tf` example:

```hcl
module "vpc" {
    source = "github.com/iamgauravpande/terraform-google-homelab//modules/vpc"
    network_name = var.network_name
}
```

`main.tf` example:

```hcl
resource "google_compute_network" "network" {
    count = length(var.network_name)
    name = var.network_name[count.index]
    auto_create_subnetworks = var.auto_create_subnetworks
}
```

`terraform.tfvars` example can be like :

```hcl
network_name = ["vpc01","vpc02"]
```