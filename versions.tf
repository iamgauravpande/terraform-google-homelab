terraform {
  required_version = ">=0.15.3"
  required_providers {
    google = {
        source = "hashicorp/google"
        version = ">=5.10.0"
    }
  }
}

provider "google" {
    project = "bitlost"
    credentials = file("./bitlost-f6081da9ef73.json")
}