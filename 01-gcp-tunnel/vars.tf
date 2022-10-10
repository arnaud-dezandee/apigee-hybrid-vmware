variable "project" {
  type = string
}
variable "region" {
  type = string
}
variable "gcp_subnet" {
  type = string
  default = "10.30.0.0/24"
}
variable "local_subnets" {
  type = list(string)
  default = [
    "10.25.0.0/24",
    "10.26.0.0/24",
  ]
}
variable "local_peer_ip" {
  type = string
}
variable "vpn_psk" {
  type = string
}
