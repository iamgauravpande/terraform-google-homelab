# Terraform Google HomeLab

This repo contains  modules to create Infrastructure on GCP using Terraform.

## Pre-Requisite 

Make sure below points exist before proceeding to use this repo:

- A GCP Account 
- A GCP Project under that account 
- A GCP API's Enabled based on resources used.
- A GCP Service Account with Owner/Editor Role.

## Examples:

### Creation of VPC:

- Use of VPC Sub-Module 

`entrypoint.tf` would reference vpc module under modules directory

```hcl
module "vpc" {
    source = "./modules/vpc"
    network_name = var.network_name
}
```

- Resource defined in vpc module to create New VPC

`main.tf` would contain the code to create a new VPC

```hcl
resource "google_compute_network" "network" {
    name = var.network_name
    auto_create_subnetworks = var.auto_create_subnetworks
}
```