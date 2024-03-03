output "clustername" {
    value = [ for i in google_container_cluster.controlplane : i.name ]
}

output "clusterversion" {
    value = [ for i in google_container_cluster.controlplane : i.master_version ]
}