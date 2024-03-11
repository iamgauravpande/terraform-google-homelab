resource "google_container_node_pool" "workernodepools" {
    for_each = var.nodepool
    name = each.value["name"]
    cluster = each.value["cluster"]
    location = each.value["location"]
    node_count = each.value["node_count"]
    max_pods_per_node = each.value["max_pods_per_node"]
    version = each.value["version"]
    node_config {
        disk_size_gb = each.value["node_config-disk_size_gb"]
        disk_type = each.value["node_config-disk_type"]
        spot = each.value["node_config-spot_instance"]
        image_type = each.value["node_config-image_type"]
        machine_type = each.value["node_config-machine_type"]
        service_account = each.value["node_config-service_account"]
        oauth_scopes = each.value["node_config-oauth_scopes"]
    }
    network_config {
        create_pod_range = each.value["network_config-create_pod_range"]
        enable_private_nodes = each.value["network_config-enable_private_nodes"]
        pod_range = each.value["network_config-pod_range"]
    }
 
}