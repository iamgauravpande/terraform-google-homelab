### Creation of Subnets:

-  To create one or more Subnets: 

`entrypoint.tf` would reference subnets module under `modules` directory

```hcl
module "subnets" {
  source  = "./modules/subnets"
  subnets = var.subnets
  secondary_ranges = var.secondary_ranges
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
    dynamic "secondary_ip_range" {
        for_each = contains(keys(var.secondary_ranges),each.value["name"]) == true ? var.secondary_ranges[each.value["name"]] : []
        content {
          range_name = secondary_ip_range.value.range_name
          ip_cidr_range = secondary_ip_range.value.secondary_ip_cidr_range
        }
    }
}
```

`terraform.tfvars` example can be like :

- Subnet creation without secondary ip ranges :

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

- Subnet creation with `secondary ip ranges` :

*NOTE: here `secondary_ranges` variable will decide under which subnet(key) the secondary ranges will be  created*

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
  "vpc02-subnet03" = {
    name              = "subnet03"
    region            = "asia-south2"
    ip_cidr_range     = "10.10.40.0/29"
    vpc_network       = "vpc02"
    private_ip_access = true
    stack_type        = "IPV4_ONLY"
  }
}

secondary_ranges = {

  "subnet03" = [
    {
      range_name = "subnet03-secondary01"
      secondary_ip_cidr_range = "192.168.64.0/29"
    },
    {
      range_name = "subnet03-secondary02"
      secondary_ip_cidr_range = "192.168.65.0/29"
    }
  ]
}
```