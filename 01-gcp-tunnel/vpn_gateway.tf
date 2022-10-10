resource "google_compute_vpn_gateway" "target_gateway" {
  name    = "vpn-apigee-vmware-gw"
  network = google_compute_network.network.id
}

resource "google_compute_forwarding_rule" "fr_esp" {
  name        = "vpn-apigee-vmware-rule-esp"
  ip_protocol = "ESP"
  ip_address  = google_compute_address.vpn_static_ip.address
  target      = google_compute_vpn_gateway.target_gateway.id
}

resource "google_compute_forwarding_rule" "fr_udp500" {
  name        = "vpn-apigee-vmware-rule-udp500"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = google_compute_address.vpn_static_ip.address
  target      = google_compute_vpn_gateway.target_gateway.id
}

resource "google_compute_forwarding_rule" "fr_udp4500" {
  name        = "vpn-apigee-vmware-rule-udp4500"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = google_compute_address.vpn_static_ip.address
  target      = google_compute_vpn_gateway.target_gateway.id
}
