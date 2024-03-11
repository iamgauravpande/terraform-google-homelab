### Creation of GKE CONTROL PLANE:

-  To create one or more GKE NodePool : 

`entrypoint.tf` would reference computeinstance module under `modules` directory

```hcl
module "gkenodepool" {
  source = "github.com/iamgauravpande/terraform-google-homelab//modules/gkenodepool"
  nodepool = var.nodepool
  depends_on = [
    module.serviceaccounts,
    module.vpc,
    module.subnets,
    module.gkecluster
  ] 
}
```

`main.tf` would contain the code to create a GKE Control Plane:

```hcl
resource "google_container_node_pool" "workernodepools" {
    for_each = var.nodepool
    name = each.value["name"]
    cluster = each.value["cluster"]
    location = each.value["location"]
    node_count = each.value["node_count"]
    max_pods_per_node = each.value["max_pods_per_node"]
    version = each.value["version"]
    node_config {
        disk_size_gb = each.value["node_config-disk_size_gb"]
        disk_type = each.value["node_config-disk_type"]
        spot = each.value["node_config-spot_instance"]
        image_type = each.value["node_config-image_type"]
        machine_type = each.value["node_config-machine_type"]
        service_account = each.value["node_config-service_account"]
        oauth_scopes = each.value["node_config-oauth_scopes"]
    }
    network_config {
        create_pod_range = each.value["network_config-create_pod_range"]
        enable_private_nodes = each.value["network_config-enable_private_nodes"]
        pod_range = each.value["network_config-pod_range"]
    }
 
}
```

`terraform.tfvars` example can be like :

```hcl
nodepool = {
  "pool01" = {
      name = "pool01"
      cluster = "cluster01"
      location = "asia-south2-a"
      node_count = 1
      max_pods_per_node = 32
      version = "1.26.10-gke.1101000"
      node_config-disk_size_gb = 10
      node_config-disk_type = "pd-ssd"
      node_config-spot_instance = true
      node_config-image_type = "UBUNTU_CONTAINERD"
      node_config-machine_type = "e2-micro"
      node_config-service_account = "gke-sa@bitlost.iam.gserviceaccount.com"
      node_config-oauth_scopes = ["cloud-platform"]
      network_config-create_pod_range = false
      network_config-enable_private_nodes = true
      network_config-pod_range = "subnet03-secondary01"
  }
}
```