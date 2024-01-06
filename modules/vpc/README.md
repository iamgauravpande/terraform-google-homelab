### Creation of VPC:

-  To create one or more VPC : 

`entrypoint.tf` would reference vpc module under `modules` directory

```hcl
module "vpc" {
    source = "./modules/vpc"
    network_name = var.network_name
}
```

`main.tf` would contain the code to create a new VPC

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