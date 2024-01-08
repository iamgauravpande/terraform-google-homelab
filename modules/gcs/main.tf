resource "google_storage_bucket" "bucket" {
    for_each = var.buckets
    name = each.value["name"]
    location = each.value["location"]
    force_destroy = each.value["force_destroy"]
    storage_class = each.value["storage_class"]
    uniform_bucket_level_access = each.value["uniform_bucket_level_access"]
    public_access_prevention = each.value["public_access_prevention"] 
}