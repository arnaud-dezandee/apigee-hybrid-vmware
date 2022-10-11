# Anthos admin workstation

Anthos Get Started (quickstarts) has 6 steps.

1. [Create a Cloud project](https://cloud.google.com/anthos/clusters/docs/on-prem/1.10/how-to/cloud-project-quickstart)
2. [Create a service account](https://cloud.google.com/anthos/clusters/docs/on-prem/1.10/how-to/service-account-quickstart)
3. [Create an admin workstation](https://cloud.google.com/anthos/clusters/docs/on-prem/1.10/how-to/admin-workstation-quickstart)
4. [Prepare for load balancing](https://cloud.google.com/anthos/clusters/docs/on-prem/1.10/how-to/seesaw-load-balance-quickstart)
5. [Create an admin cluster](https://cloud.google.com/anthos/clusters/docs/on-prem/1.10/how-to/admin-cluster-quickstart)
6. [Create a user cluster](https://cloud.google.com/anthos/clusters/docs/on-prem/1.10/how-to/user-cluster-quickstart)

## Enable APIs and Service account

We will do step 1 and 2 with `terraform`:

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

Then follow [Create an admin workstation (quickstart)](https://cloud.google.com/anthos/clusters/docs/on-prem/1.10/how-to/admin-workstation-quickstart) with the provided files:

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

[Anthos: clusters](03-anthos-clusters/README.md)
