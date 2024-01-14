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

resource "google_service_account_key" "key" {
    count = length(var.serviceaccount_key)
    service_account_id = var.serviceaccount_key[count.index]
    depends_on = [ 
        google_service_account.service_account,
        google_project_iam_binding.bindings        
    ]
}

resource "local_file" "sa_jsonkey" {
    count = length(var.serviceaccount_key)
    content = base64decode(google_service_account_key.key[count.index].private_key)
    filename = "${path.root}/keys/${google_service_account_key.key[count.index].service_account_id}.json"
}