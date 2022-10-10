resource "google_compute_firewall" "fw_local" {
  name          = "apigee-vmware-firewall"
  network       = google_compute_network.network.name
  source_ranges = var.local_subnets

  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }
}

resource "google_compute_firewall" "fw_internal" {
  name          = "apigee-vmware-allow-internal"
  network       = google_compute_network.network.name
  source_ranges = [var.gcp_subnet]

  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }
}
