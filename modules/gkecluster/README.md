### Creation of GKE CONTROL PLANE:

-  To create one or more GKE Control Plane : 

`entrypoint.tf` example:

```hcl
module "gkecluster" {
  source = "github.com/iamgauravpande/terraform-google-homelab//modules/gkecluster"
  gkecluster = var.gkecluster
  depends_on = [
    module.vpc,
    module.subnets
  ] 
}
```

`main.tf` example:

```hcl
resource "google_container_cluster" "controlplane" {
    for_each = var.gkecluster
    name = each.value["name"]
    location = each.value["location"]
    remove_default_node_pool = each.value["remove_default_node_pool"]
    initial_node_count = each.value["initial_node_count"]
    deletion_protection = each.value["deletion_protection"]
    networking_mode = each.value["networking_mode"]
    network = each.value["network"]
    min_master_version = each.value["min_master_version"]
    subnetwork = each.value["subnetwork"]
    release_channel {
        channel = each.value["release_channel"]
    }
    ip_allocation_policy {
        stack_type = each.value["stack_type"]
        cluster_secondary_range_name = each.value["cluster_secondary_range_name"]
        services_secondary_range_name = each.value["services_secondary_range_name"]
    }
    private_cluster_config {
        enable_private_nodes = each.value["enable_private_nodes"]
        master_ipv4_cidr_block = each.value["master_ipv4_cidr_block"]
    }
    
}
```

`terraform.tfvars` example can be like :

```hcl
gkecluster = {
  "cluster01" = {
    name = "cluster01"
    location = "asia-south2-a"
    initial_node_count = 1
    remove_default_node_pool = true
    initial_node_count = 1
    deletion_protection = false
    networking_mode = "VPC_NATIVE"
    release_channel = "STABLE"
    min_master_version = "1.26.10-gke.1101000"
    network = "vpc02"
    subnetwork = "subnet03"
    cluster_secondary_range_name = "subnet03-secondary01"
    services_secondary_range_name = "subnet03-secondary02"
    stack_type = "IPV4" 
    enable_private_nodes = true
    master_ipv4_cidr_block = "172.16.0.48/28"
  }
}
```