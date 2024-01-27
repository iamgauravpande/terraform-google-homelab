### Creation of GCS Bucket:

-  To create one or more bucket : 

`entrypoint.tf` would reference vpc module under `modules` directory

```hcl
module "gcs" {
  source  = "iamgauravpande/homelab/google//modules/gcs"
  buckets =  var.buckets
}
```

`main.tf` would contain the code to create a bucket resource:

```hcl
resource "google_storage_bucket" "bucket" {
    for_each = var.buckets
    name = each.value["name"]
    location = each.value["location"]
    force_destroy = each.value["force_destroy"]
    storage_class = each.value["storage_class"]
    uniform_bucket_level_access = each.value["uniform_bucket_level_access"]
    public_access_prevention = each.value["public_access_prevention"] 
}
```

`terraform.tfvars` example can be like :

```hcl
buckets = {
  "gcs-01" = {
    name = "homelab-gcs-01"
    location = "asia-south2"    
  }

  "gcs-02" = {
    name = "homelab-gcs-02"
    location = "asia-south1"    
  }
}
```