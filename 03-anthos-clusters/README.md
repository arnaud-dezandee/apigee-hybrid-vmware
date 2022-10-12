# Anthos clusters

For these steps, open a terminal (SSH) on the Anthos admin workstation created previously.

## Admin cluster

Follow [Create an admin cluster](https://cloud.google.com/anthos/clusters/docs/on-prem/latest/how-to/create-admin-cluster) with the provided files:

* [`admin-cluster.yaml`](./admin-cluster.yaml)
* [`admin-cluster-ipblock.yaml`](./admin-cluster-ipblock.yaml)

```
gkectl check-config --config admin-cluster.yaml
gkectl prepare --config admin-cluster.yaml
gkectl create admin --config admin-cluster.yaml
```

## User cluster

Next up [Create a user cluster](https://cloud.google.com/anthos/clusters/docs/on-prem/latest/how-to/create-user-cluster):

* [`user-cluster.yaml`](./user-cluster.yaml)
* [`user-cluster-ipblock.yaml`](./user-cluster-ipblock.yaml)

```
gkectl check-config --kubeconfig kubeconfig --config user-cluster.yaml
gkectl create cluster --kubeconfig kubeconfig --config user-cluster.yaml
```

## Connecting to Cloud console

Follow [Connecting to a cluster from the Google Cloud console](https://cloud.google.com/anthos/clusters/docs/on-prem/1.10/how-to/connecting-to-a-cluster)

Provided file:
* [`cloud-console-reader.yaml`](./cloud-console-reader.yaml)

```
kubectl apply --kubeconfig kubeconfig -f cloud-console-reader.yaml
kubectl apply --kubeconfig USER_CLUSTER_KUBECONFIG -f cloud-console-reader.yaml
```

Then fetch and setup the Kubernetes service account tokens in the GCP Console
