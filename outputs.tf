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

output "computeinstance" {
    value = module.computeinstance.computeinstance
    sensitive = true
}
output "clustername" {
    value = [ for i in module.gkecluster.clustername : i ]
}

output "clusterversion" {
    value = [ for i in module.gkecluster.clusterversion : i ]
}

output "nodepoolname" {
    value = [ for i in module.gkenodepool.nodepoolname : i ]
}

output "nodepoolversion" {
    value = [ for i in module.gkenodepool.nodepoolversion : i ]
}