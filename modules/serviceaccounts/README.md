### Creation of ServiceAccount:

-  To create one or more ServiceAccount : 

`entrypoint.tf` would reference serviceaccounts module under `modules` directory

```hcl
module "serviceaccounts" {
  source = "./modules/serviceaccounts"
  serviceaccount = var.serviceaccount
}
```

`main.tf` would contain the code to create a new service_account

```hcl
resource "google_service_account" "service_account" {
    for_each = var.serviceaccount
    account_id = each.value["account_id"]
    display_name = each.value["display_name"]
    description = each.value["description"]
    disabled = each.value["disabled"]
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
```