resource "google_compute_subnetwork" "subnetwork" {
    for_each = var.subnets
    name = each.value["name"]
    network = each.value["vpc_network"]
    region = each.value["region"]
    ip_cidr_range = each.value["ip_cidr_range"]
    private_ip_google_access = each.value["private_ip_access"]
    stack_type = each.value["stack_type"]
    dynamic "secondary_ip_range" {
        for_each = contains(keys(var.secondary_ranges),each.value["name"]) == true ? var.secondary_ranges[each.value["name"]] : []
        content {
          range_name = secondary_ip_range.value.range_name
          ip_cidr_range = secondary_ip_range.value.secondary_ip_cidr_range
        }
    }
}