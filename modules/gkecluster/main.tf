resource "google_container_cluster" "controlplane" {
    for_each = var.gkecluster
    name = each.value["name"]
    location = each.value["location"]
    remove_default_node_pool = each.value["remove_default_node_pool"]
    initial_node_count = each.value["initial_node_count"]
    deletion_protection = each.value["deletion_protection"]
    networking_mode = each.value["networking_mode"]
    network = each.value["network"]
    min_master_version = each.value["min_master_version"]
    subnetwork = each.value["subnetwork"]
    release_channel {
        channel = each.value["release_channel"]
    }
    ip_allocation_policy {
        stack_type = each.value["stack_type"]
        cluster_secondary_range_name = each.value["cluster_secondary_range_name"]
        services_secondary_range_name = each.value["services_secondary_range_name"]
    }
    private_cluster_config {
        enable_private_nodes = each.value["enable_private_nodes"]
        master_ipv4_cidr_block = each.value["master_ipv4_cidr_block"]
    }
    
}