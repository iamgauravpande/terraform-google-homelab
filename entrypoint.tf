module "vpc" {
    source = "./modules/vpc"
    network_name = var.network_name
}