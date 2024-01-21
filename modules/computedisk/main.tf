resource "google_compute_disk" "disk" {
    for_each = var.disk
    name = each.value["name"]
    type = each.value["type"]
    zone = each.value["zone"]
    image = each.value["image"]
    size = each.value["disk_size"]
    labels = each.value["labels"]
}