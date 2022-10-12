# Apigee Hybrid

We can now follow the Apigee Hybrid runtime [installation](https://cloud.google.com/apigee/docs/hybrid/v1.7/big-picture)

## Part 1: Project and org setup

Follow the [Part 1](https://cloud.google.com/apigee/docs/hybrid/v1.7/precog-overview) tutorial to set up the GCP project and apigee org

## Part 2: Hybrid runtime setup

All steps up to [Step 4: Install apigeectl](https://cloud.google.com/apigee/docs/hybrid/v1.7/install-apigeectl) should already be done by now

Install `apigeectl`

```
cd 05-apigee-hybrid/
export VERSION=1.7.2
curl -LO https://storage.googleapis.com/apigee-release/hybrid/apigee-hybrid-setup/$VERSION/apigeectl_linux_64.tar.gz
tar xvzf apigeectl_linux_64.tar.gz -C ./
mv apigeectl_1.7.2-e080e04_linux_64 apigeectl
```

Check `apigeectl` version

```
./apigeectl/apigeectl version
Version: 1.7.2
Commit: e080e04
Build ID: 1193
Build Time: 2022-06-24T22:06:40Z
Go Version: go1.17.8
```

Then follow steps 5-8 of tutorial if necessary

Next, we can deploy/update the Apigee runtime

```
cd 05-apigee-hybrid/hybrid-files
export KUBECONFIG=__ANTHOS_USER_CLUSTER_CONFIG__
../apigeectl/apigeectl init -f overrides/overrides.yaml
../apigeectl/apigeectl check-ready -f overrides/overrides.yaml
../apigeectl/apigeectl apply -f overrides/overrides.yaml
../apigeectl/apigeectl check-ready -f overrides/overrides.yaml
```
