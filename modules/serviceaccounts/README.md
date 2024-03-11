### Creation of ServiceAccount:

-  To create one or more ServiceAccount : 

`entrypoint.tf` example:

```hcl
module "serviceaccounts" {
  source = "github.com/iamgauravpande/terraform-google-homelab//modules/serviceaccounts"
  serviceaccount = var.serviceaccount
  bindings = var.bindings
  project = var.project
}
```

`main.tf` example:

1. To create a new service_account:

```hcl
resource "google_service_account" "service_account" {
    for_each = var.serviceaccount
    account_id = each.value["account_id"]
    display_name = each.value["display_name"]
    description = each.value["description"]
    disabled = each.value["disabled"]
}
```

2. To create project iam bindings for created service accounts:

```hcl
resource "google_project_iam_binding" "bindings" {
    project = var.project
    for_each = var.bindings
    role = each.key
    members = each.value
}
```

`terraform.tfvars` example can be like :

```hcl
serviceaccount = {
  "loki-gcs" = {
    account_id = "loki-gcs"
    
  }
  "cert-manager-dns01" = {
    account_id = "cert-manager-dns01"
  }
}

project = "bitlost"

bindings = {
  "roles/storage.admin" = [ 
    "serviceAccount:loki-gcs@bitlost.iam.gserviceaccount.com"
  ]

  "roles/dns.admin" = [ 
    "serviceAccount:cert-manager-dns01@bitlost.iam.gserviceaccount.com" 
  ]
}
```