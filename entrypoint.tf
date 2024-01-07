module "vpc" {
  source       = "./modules/vpc"
  network_name = var.network_name
}

module "subnets" {
  source  = "./modules/subnets"
  subnets = var.subnets
  secondary_ranges = var.secondary_ranges
  depends_on = [
    module.vpc
  ]
}