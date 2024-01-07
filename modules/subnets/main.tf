resource "google_compute_subnetwork" "subnetwork" {
    for_each = var.subnets
    name = each.value["name"]
    network = each.value["vpc_network"]
    region = each.value["region"]
    ip_cidr_range = each.value["ip_cidr_range"]
    private_ip_google_access = each.value["private_ip_access"]
    stack_type = each.value["stack_type"]
}