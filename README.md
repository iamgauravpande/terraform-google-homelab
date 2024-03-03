# Terraform Google HomeLab

This module contains terraform code  to create Infrastructure on GCP. Individal submodules can also be used to create specific resoruces.

## Pre-Requisite 

Make sure below points exist before proceeding to use this repo:

- A GCP Account 
- A GCP Project under that account 
- GCP API's Enabled based on resources used.
- A GCP Service Account with Owner/Editor Role.


## Authenticate to GCP : 

Follow this link [gcp-authenticate] to use one of many methods suggested to authenticate to gcp provider.



## Provision Commands :

- `terraform init` to get the plugins/modules
- `terraform plan` to see the speculative infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure

## How to Use this Module:

Create `main.tf` that has below input variable structure:

```hcl
module "homelab" {
  source  = "iamgauravpande/homelab/google"
  version = "1.1.0"
  project = var.project
  network_name = var.network_name
  subnets = var.subnets
  secondary_ranges = var.secondary_ranges
  serviceaccount = var.serviceaccount  
  bindings = var.bindings
  serviceaccount_key = var.serviceaccount_key
  disk = var.disk
  computeinstance = var.computeinstance
  buckets = var.buckets 
  gkecluster = var.gkecluster 
}
```

Create `variables.tf` that below structure: 


```hcl
variable "network_name" {
  description = "The Name of the network"
  type        = list(string)
}

variable "auto_create_subnetworks" {
  description = "When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources"
  type        = bool
  default     = false
}
variable "subnets" {
    type = map(object({
        name = string
        region = string
        ip_cidr_range = string
        vpc_network = string
        private_ip_access = bool
        stack_type = string
    }))
}
variable "secondary_ranges" {
    type = map(list(object({
        range_name = string
        secondary_ip_cidr_range = string
    })))
    default = {}
}

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
variable "serviceaccount_key" {
  type = list(string)
}

variable "disk" {
    type = map(object({
      name = string
      type = string
      zone = string
      image = string
      labels = optional(map(string))
      disk_size = number
    }))
}

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
variable "gkecluster" {
    type = map(object({
      name = string
      location = string
      remove_default_node_pool = bool
      initial_node_count = number
      deletion_protection = bool
      networking_mode = string
      release_channel = string
      min_master_version = string
      network = string
      subnetwork = string
      cluster_secondary_range_name = string
      services_secondary_range_name = string
      stack_type = string 
      enable_private_nodes = bool
      master_ipv4_cidr_block    = string
    })) 
}
```

Sample `terraform.tfvars` structure can be : 

```hcl
network_name = ["vpc01", "vpc02"]

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
      secondary_ip_cidr_range = "192.168.60.0/24"
    },
    {
      range_name = "subnet03-secondary02"
      secondary_ip_cidr_range = "192.168.70.0/24"
    }
  ]
}

buckets = {
  "gcs-01" = {
    name = "homelab-gcs-01"
    location = "asia-south2"    
  }

  "gcs-02" = {
    name = "homelab-gcs-02"
    location = "asia-south1"    
  }
}

serviceaccount = {
  "loki-gcs" = {
    account_id = "loki-gcs"
    
  }
  "cert-manager-dns01" = {
    account_id = "cert-manager-dns01"
  }
  "compute" = {
    account_id = "compute"
  }
}

project = "bitlost"
bindings = {
  "roles/storage.admin" = [ 
    "serviceAccount:loki-gcs@bitlost.iam.gserviceaccount.com"
  ]

  "roles/dns.admin" = [ 
    "serviceAccount:cert-manager-dns01@bitlost.iam.gserviceaccount.com"
  ]

  "roles/compute.admin" = [ 
    "serviceAccount:compute@bitlost.iam.gserviceaccount.com" 
  ]
}

serviceaccount_key = [  ]

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

gkecluster = {
  "cluster01" = {
    name = "cluster01"
    location = "asia-south2-a"
    initial_node_count = 1
    remove_default_node_pool = true
    initial_node_count = 1
    deletion_protection = false
    networking_mode = "VPC_NATIVE"
    release_channel = "STABLE"
    min_master_version = "1.26.10-gke.1101000"
    network = "vpc02"
    subnetwork = "subnet03"
    cluster_secondary_range_name = "subnet03-secondary01"
    services_secondary_range_name = "subnet03-secondary02"
    stack_type = "IPV4" 
    enable_private_nodes = true
    master_ipv4_cidr_block = "172.16.0.48/28"
  }
}
```

## Use Individual Sub-modules under this Module:

To use submodule go to [modules] and based on submodule you want to use check its  `README` file.


[gcp-authenticate]: https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#authentication
[modules]: https://github.com/iamgauravpande/terraform-google-homelab/tree/main/modules