output "network_name" {
  value = [for network in google_compute_network.network: network.name]
  description = "The name of VPC being created"
}