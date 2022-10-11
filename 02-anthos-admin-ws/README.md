# Anthos admin workstation

## GCP ressources

Enable APIs and create the `component-access` service account with `terraform`:

```
export GOOGLE_APPLICATION_CREDENTIALS="<path/to/adc_file.json>"

terraform init
terraform plan
terraform apply
```

## Create admin workstation

In order to create the Anthos admin WS, your computer needs direct access to:

* VMware vCenter Server: `vCenter.local:443`
* VMware ESXi hosts
* Anthos admin WS subnet
* Google APIs

Then follow [Creating an admin workstation](https://cloud.google.com/anthos/clusters/docs/on-prem/latest/how-to/create-admin-workstation) with the provided files:

* `vcenter.crt`: [vCenter CA cert]((https://cloud.google.com/anthos/clusters/docs/on-prem/latest/how-to/minimal-create-clusters))
* [`admin-ws-config.yaml`](./admin-ws-config.yaml)
* [`credential.yaml`](./credential.yaml): fill in vCenter username and password

```
cd 02-anthos-admin-ws/
gsutil cp gs://gke-on-prem-release/gkeadm/1.10.3-gke.49/linux/gkeadm ./
chmod +x gkeadm
```

Then create the VM

```
./gkeadm create admin-workstation --auto-create-service-accounts
```

## Next

[Anthos: clusters](../03-anthos-clusters/README.md)
