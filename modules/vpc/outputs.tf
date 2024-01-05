output "network_name" {
  value = google_compute_network.network.name
  description = "The name of VPC being created"
}