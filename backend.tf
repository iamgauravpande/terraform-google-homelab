terraform {
  backend "gcs" {
    bucket  = "tf-homelab-bucket"
    prefix  = "homelab"
    project = "bitlost"
    credentials = "bitlost-f6081da9ef73.json"
  }
}