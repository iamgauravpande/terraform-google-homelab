resource "google_compute_network" "network" {
    count = length(var.network_name)
    name = var.network_name[count.index]
    auto_create_subnetworks = var.auto_create_subnetworks
}