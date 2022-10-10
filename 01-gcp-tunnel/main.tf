terraform {
  required_version = ">= 1.1.3"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">=4.26.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
}
