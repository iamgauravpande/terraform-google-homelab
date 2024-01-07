module "vpc" {
  source       = "./modules/vpc"
  network_name = var.network_name
}

module "subnets" {
  source  = "./modules/subnets"
  subnets = var.subnets
  depends_on = [
    module.vpc
  ]
}