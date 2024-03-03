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
module "gcs" {
  source  = "./modules/gcs"
  buckets =  var.buckets
}

module "serviceaccounts" {
  source = "./modules/serviceaccounts"
  serviceaccount = var.serviceaccount
  bindings = var.bindings
  project = var.project
  serviceaccount_key = var.serviceaccount_key
}
module "computedisk" {
  source  = "./modules/computedisk"
  disk = var.disk
}

module "computeinstance" {
  source = "./modules/computeinstance"
  computeinstance = var.computeinstance
  depends_on = [ 
    module.vpc,
    module.subnets,
    module.computedisk,
    module.serviceaccounts
  ]
}

module "gkecluster" {
  source = "./modules/gkecluster"
  gkecluster = var.gkecluster
  depends_on = [
    module.vpc,
    module.subnets
  ] 
}