# Terraform Google HomeLab

This repo contains  modules to create Infrastructure on GCP using Terraform.

## Pre-Requisite 

Make sure below points exist before proceeding to use this repo:

- A GCP Account 
- A GCP Project under that account 
- A GCP API's Enabled based on resources used.
- A GCP Service Account with Owner/Editor Role.

## Provision:

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the speculative infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destry` to destroy the built infrastructure