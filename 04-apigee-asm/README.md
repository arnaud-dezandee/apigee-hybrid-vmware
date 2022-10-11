# Apigee Anthos Service Mesh (ASM)

## Build offline bundle

The Anthos admin workstation only have limited access to Google APIs through the VPN tunnel. In order to install ASM, a wider internet access is required (github.com).

We can however build an offline bundle and transfer required files to the workstation.

On a computer with internet access (Linux), install `asmcli` following the instructions in [Install required tools.](https://cloud.google.com/service-mesh/v1.12/docs/unified-install/install-dependent-tools#install_required_tools)

```
curl https://storage.googleapis.com/csm-artifacts/asm/asmcli_1.13 > asmcli
chmod +x asmcli
```

Create offline package

```
./asmcli build-offline-package -D asm-files -v
tar -czvf asm-offline.tar.gz asm-files
```

Upload archive to Anthos admin workstation

```
scp asm-offline.tar.gz ubuntu@10.25.0.2
```

Back on the admin workstation, authenticate with a privileged service account on `gcloud` tool

```
gcloud config configurations create install
gcloud auth activate-service-account vmware-install@_YOUR_GCP_PROJECT_ID_.iam.gserviceaccount.com \
  --key-file _YOUR_GCP_PROJECT_ID_-546611ea359c.json \
  --project=_YOUR_GCP_PROJECT_ID_
```

Unarchive the offline bundle and install asm with the provided file:

* [`overlay.yaml`](./overlay.yaml)

```
curl https://storage.googleapis.com/csm-artifacts/asm/asmcli_1.13 > asmcli
chmod +x asmcli

tar -xzvf asm-offline.tar.gz

./asmcli install \
  --kubeconfig /home/ubuntu/gke-apigee-user-cluster1-kubeconfig \
  --fleet_id apigee-hybrid-vmware \
  --output_dir asm-files \
  --platform multicloud \
  --enable_all --ca mesh_ca \
  --custom_overlay overlay.yaml \
  --option legacy-default-ingressgateway \
  --offline -v
```

Expected install output:

```
asmcli: *****************************
asmcli: The ASM control plane installation is now complete.
asmcli: To enable automatic sidecar injection on a namespace, you can use the following command:
asmcli: kubectl label namespace <NAMESPACE> istio-injection- istio.io/rev=asm-1134-4 --overwrite
asmcli: If you use 'istioctl install' afterwards to modify this installation, you will need
asmcli: to specify the option '--set revision=asm-1134-4' to target this control plane
asmcli: instead of installing a new one.
asmcli: To finish the installation, enable Istio sidecar injection and restart your workloads.
asmcli: For more information, see:
asmcli: https://cloud.google.com/service-mesh/docs/proxy-injection
asmcli: The ASM package used for installation can be found at:
asmcli: /home/ubuntu/asm/asm-files/asm
asmcli: The version of istioctl that matches the installation can be found at:
asmcli: /home/ubuntu/asm/asm-files/istio-1.13.4-asm.4/bin/istioctl
asmcli: A symlink to the istioctl binary can be found at:
asmcli: /home/ubuntu/asm/asm-files/istioctl
asmcli: The combined configuration generated for installation can be found at:
asmcli: /home/ubuntu/asm/asm-files/asm-1134-4-manifest-raw.yaml
asmcli: The full, expanded set of kubernetes resources can be found at:
asmcli: /home/ubuntu/asm/asm-files/asm-1134-4-manifest-expanded.yaml
asmcli: *****************************
asmcli: Successfully installed ASM.
```
