network_name = ["vpc01", "vpc02"]

subnets = {
  "vpc01-subnet01" = {
    name              = "subnet01"
    region            = "asia-south2"
    ip_cidr_range     = "10.10.20.0/29"
    vpc_network       = "vpc01"
    private_ip_access = true
    stack_type        = "IPV4_ONLY"
  }
  "vpc02-subnet02" = {
    name              = "subnet02"
    region            = "asia-south2"
    ip_cidr_range     = "10.10.30.0/29"
    vpc_network       = "vpc02"
    private_ip_access = true
    stack_type        = "IPV4_ONLY"
  }
  "vpc02-subnet03" = {
    name              = "subnet03"
    region            = "asia-south2"
    ip_cidr_range     = "10.10.40.0/29"
    vpc_network       = "vpc02"
    private_ip_access = true
    stack_type        = "IPV4_ONLY"
  }
}

secondary_ranges = {

  "subnet03" = [
    {
      range_name = "subnet03-secondary01"
      secondary_ip_cidr_range = "192.168.64.0/29"
    },
    {
      range_name = "subnet03-secondary02"
      secondary_ip_cidr_range = "192.168.65.0/29"
    }
  ]
}

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

serviceaccount = {
  "loki-gcs" = {
    account_id = "loki-gcs"
    
  }
  "cert-manager-dns01" = {
    account_id = "cert-manager-dns01"
  }
  "compute" = {
    account_id = "compute"
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

  "roles/compute.admin" = [ 
    "serviceAccount:compute@bitlost.iam.gserviceaccount.com" 
  ]
}

serviceaccount_key = [  ]

disk = {
  "disk01" = {
    name = "disk01"
    type = "pd-ssd"
    zone = "asia-south2-a"
    image = "ubuntu-minimal-2204-jammy-v20240119"
    labels = {
      environment = "homelab"
      app = "vm01"
    }
    disk_size = 10
  }
  "disk02" = {
    name = "disk02"
    type = "pd-ssd"
    zone = "asia-south2-b"
    image = "ubuntu-minimal-2204-jammy-v20240119"
    labels = {
      environment = "homelab"
      app = "vm02"
    }
    disk_size = 10
  }
}

computeinstance = {
  "instance01" = {
    name = "instance01"
    machine_type = "e2-micro"
    zone = "asia-south2-a"
    subnetwork = "subnet01"
    boot_disk_source = "disk01"
    boot_disk_auto_delete = "false"
    boot_disk_mode = "READ_WRITE"
    service_account_email = "compute@bitlost.iam.gserviceaccount.com"
    service_account_scopes = ["cloud-platform"]
    allow_stopping_for_update = "true"
  }

  "instance02" = {
    name = "instance02"
    machine_type = "e2-micro"
    zone = "asia-south2-b"
    subnetwork = "subnet02"
    boot_disk_source = "disk02"
    boot_disk_auto_delete = "false"
    boot_disk_mode = "READ_WRITE"
    service_account_email = "compute@bitlost.iam.gserviceaccount.com"
    service_account_scopes = ["cloud-platform"]
    allow_stopping_for_update = "true"
  }

}