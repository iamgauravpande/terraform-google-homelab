output "network_name" {
  value       = module.vpc.network_name
  description = "The name of VPC being created"
}
output "subnets" {
  value = module.subnets.subnets
}
output "bucket" {
  value = module.gcs.bucket
}
output "serviceaccount" {
    value = module.serviceaccounts.serviceaccount
}
output "serviceaccount_key" {
    value = [ for i in module.serviceaccounts.serviceaccount_key : i ]
    sensitive = true
}

output "disk" {
    value = module.computedisk.disk
}