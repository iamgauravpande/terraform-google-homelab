### Creation of Subnets:

-  To create one or more Subnets: 

`entrypoint.tf` would reference subnets module under `modules` directory

```hcl
module "subnets" {
  source  = "./modules/subnets"
  subnets = var.subnets
  depends_on = [
    module.vpc
  ]
}
```

`main.tf` would contain the code to create a new Subnet:

```hcl
resource "google_compute_subnetwork" "subnetwork" {
    for_each = var.subnets
    name = each.value["name"]
    network = each.value["vpc_network"]
    region = each.value["region"]
    ip_cidr_range = each.value["ip_cidr_range"]
    private_ip_google_access = each.value["private_ip_access"]
    stack_type = each.value["stack_type"]
}
```

`terraform.tfvars` example can be like :

*NOTE: here `vpc_network` parameter will decide under which VPC the subnet is created*

```hcl
subnets = {
  "vpc01-subnet01" = {
    name              = "subnet01"
    region            = "asia-south2"
    ip_cidr_range     = "10.10.20.0/29"
    vpc_network       = "vpc01"
    private_ip_access = true
    stack_type        = "IPV4_ONLY"
  }
  "vpc02-subnet02" = {
    name              = "subnet02"
    region            = "asia-south2"
    ip_cidr_range     = "10.10.30.0/29"
    vpc_network       = "vpc02"
    private_ip_access = true
    stack_type        = "IPV4_ONLY"
  }
}
```