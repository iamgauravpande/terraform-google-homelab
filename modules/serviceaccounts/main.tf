resource "google_service_account" "service_account" {
    for_each = var.serviceaccount
    account_id = each.value["account_id"]
    display_name = each.value["display_name"]
    description = each.value["description"]
    disabled = each.value["disabled"]
}

resource "google_project_iam_binding" "bindings" {
    project = var.project
    for_each = var.bindings
    role = each.key
    members = each.value
    depends_on = [ 
        google_service_account.service_account 
    ]
}