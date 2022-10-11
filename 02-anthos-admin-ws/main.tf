terraform {
  required_version = ">= 1.1.3"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">=4.26.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.2.3"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
}

provider "local" {
}
