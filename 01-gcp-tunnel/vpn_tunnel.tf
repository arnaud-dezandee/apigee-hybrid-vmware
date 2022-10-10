resource "google_compute_vpn_tunnel" "tunnel" {
  name          = "vpn-apigee-vmware-tunnel"
  peer_ip       = var.local_peer_ip
  shared_secret = var.vpn_psk

  target_vpn_gateway = google_compute_vpn_gateway.target_gateway.id

  local_traffic_selector  = ["0.0.0.0/0"]
  remote_traffic_selector = ["0.0.0.0/0"]

  depends_on = [
    google_compute_forwarding_rule.fr_esp,
    google_compute_forwarding_rule.fr_udp500,
    google_compute_forwarding_rule.fr_udp4500,
  ]
}

resource "google_compute_route" "routes" {
  for_each = toset(var.local_subnets)
  name                = "vpn-apigee-vmware-tunnel-route-${index(var.local_subnets, each.value) + 1}"
  dest_range          = each.value
  network             = google_compute_network.network.name
  next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel.id
  priority            = 1000
  tags                = []
}
