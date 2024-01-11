resource "google_service_account" "service_account" {
    for_each = var.serviceaccount
    account_id = each.value["account_id"]
    display_name = each.value["display_name"]
    description = each.value["description"]
    disabled = each.value["disabled"]
}