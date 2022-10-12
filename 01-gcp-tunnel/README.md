# GCP Tunnel

## Networking, VPN Tunnel

The subnet that will host all VMs inside the VMware datacenter needs to talk to Google APIs for Anthos and Apigee management plane. Traffic is routed through a site-to-site IPsec VPN between Google Cloud and the on-prem DC.

This is achieved with the combination of those 3 items:
* GCP subnet with [Private Google Access](https://cloud.google.com/vpc/docs/private-google-access)
* IPsec tunnel routing:
  ```
  $ ipsec status
  Routed Connections:
          con3{3985}:  ROUTED, TUNNEL, reqid 7
          con3{3985}:   10.25.0.0/24|/0 10.26.0.64/24|/0 === 10.30.0.0/24|/0 199.36.153.8/30|/0
  Security Associations (1 up, 0 connecting):
          con3[906]: ESTABLISHED 3 hours ago
          con3{3986}:  INSTALLED, TUNNEL, reqid 7, ESP SPIs: c17adfea_i ec8672b1_o
          con3{3986}:   10.25.0.0/24|/0 10.26.0.64/24|/0 === 10.30.0.0/24|/0 199.36.153.8/30|/0
  ```
* DNS override:
  ```
  $ dig +short googleapis.com
  199.36.153.8
  199.36.153.9
  199.36.153.11
  199.36.153.10
  ```

### Required CLI tools

* Google Cloud SDK [documentation](https://cloud.google.com/sdk/)
* Terraform [documentation](https://learn.hashicorp.com/tutorials/terraform/install-cli)

### Create GCP resources

Fetch a GCP [Application Default Credentials (ADC)](https://cloud.google.com/docs/authentication/application-default-credentials)

```
export GOOGLE_APPLICATION_CREDENTIALS="<path/to/adc_file.json>"
```

Then you can execute `terraform`

```
terraform init
terraform plan -var 'vpn_psk=<IPSEC_PSK>'
terraform apply -var 'vpn_psk=<IPSEC_PSK>'
```
