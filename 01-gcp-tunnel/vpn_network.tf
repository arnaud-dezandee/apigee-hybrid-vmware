resource "google_compute_network" "network" {
  name                    = "apigee-vmware-vpc"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "subnet" {
  name                     = "apigee-vmware-subnet"
  ip_cidr_range            = var.gcp_subnet
  region                   = var.region
  network                  = google_compute_network.network.id
  private_ip_google_access = true
}

resource "google_compute_address" "vpn_static_ip" {
  name = "apigee-vmware-vpn-address"
}

output "google_peer_ip" {
  value = google_compute_address.vpn_static_ip.address
}
