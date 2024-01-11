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