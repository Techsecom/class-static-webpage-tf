terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.44.1"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.63.0"
    }
  }
}