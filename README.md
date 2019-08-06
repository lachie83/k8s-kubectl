# Kubernetes Client

### Azure DevOps Build Status
[![Build Status](https://dev.azure.com/laevenso/k8s/_apis/build/status/lachie83.k8s-kubectl)](https://dev.azure.com/laevenso/k8s/_build/latest?definitionId=1)

### Container Details
[![](https://images.microbadger.com/badges/image/lachlanevenson/k8s-kubectl.svg)](http://microbadger.com/images/lachlanevenson/k8s-kubectl "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/lachlanevenson/k8s-kubectl.svg)](http://microbadger.com/images/lachlanevenson/k8s-kubectl "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/commit/lachlanevenson/k8s-kubectl.svg)](http://microbadger.com/images/lachlanevenson/k8s-kubectl "Get your own commit badge on microbadger.com")

# Supported tags and respective `Dockerfile` links
* `v1.15.2`, `latest`    [(v1.15.2/Dockerfile)](https://github.com/lachie83/k8s-kubectl/blob/v1.15.2/Dockerfile)
* `v1.14.5`,    [(v1.14.5/Dockerfile)](https://github.com/lachie83/k8s-kubectl/blob/v1.14.5/Dockerfile)
* `v1.13.9`,    [(v1.13.9/Dockerfile)](https://github.com/lachie83/k8s-kubectl/blob/v1.13.9/Dockerfile)
* `v1.12.10`,    [(v1.12.10/Dockerfile)](https://github.com/lachie83/k8s-kubectl/blob/v1.12.10/Dockerfile)
* `v1.11.9`,    [(v1.11.9/Dockerfile)](https://github.com/lachie83/k8s-kubectl/blob/v1.11.9/Dockerfile)
* `v1.10.12`,   [(v1.10.12/Dockerfile)](https://github.com/lachie83/k8s-kubectl/blob/v1.10.12/Dockerfile)
* `v1.9.10`,    [(v1.9.10/Dockerfile)](https://github.com/lachie83/k8s-kubectl/blob/v1.9.10/Dockerfile)
* `v1.8.15`,    [(v1.8.15/Dockerfile)](https://github.com/lachie83/k8s-kubectl/blob/v1.8.15/Dockerfile)
* `v1.7.16`     [(v1.7.16/Dockerfile)](https://github.com/lachie83/k8s-kubectl/blob/v1.7.16/Dockerfile)
* `v1.6.13`,    [(v1.6.13/Dockerfile)](https://github.com/lachie83/k8s-kubectl/blob/v1.6.13/Dockerfile)
* `v1.5.8`,     [(v1.5.8/Dockerfile)](https://github.com/lachie83/k8s-kubectl/blob/v1.5.8/Dockerfile)
* `v1.4.12`,    [(v1.4.12/Dockerfile)](https://github.com/lachie83/k8s-kubectl/blob/v1.4.12/Dockerfile)
* `v1.3.10`,    [(v1.3.10/Dockerfile)](https://github.com/lachie83/k8s-kubectl/blob/v1.3.10/Dockerfile)
* `v1.2.6`,     [(v1.2.6/Dockerfile)](https://github.com/lachie83/k8s-kubectl/blob/v1.2.6/Dockerfile)
* `v1.1.8`,     [(v1.1.8/Dockerfile)](https://github.com/lachie83/k8s-kubectl/blob/v1.1.8/Dockerfile)
* `v1.0.7`,     [(v1.0.7/Dockerfile)](https://github.com/lachie83/k8s-kubectl/blob/v1.0.7/Dockerfile)

## Overview
This container provides the Kubernetes client kubectl which can be used to interact with a Kubernetes cluster

## Build
`make docker_build`

## Run
`docker run --rm lachlanevenson/k8s-kubectl:``git rev-parse --abbrev-ref HEAD`` --server=http://<server-name>:8080 get pods`

## Data Container

In order to get kube spec files accessible via the kubectl container please use the following data container that exposes a data volume under /data. It dumps everything under cwd in the data container.

```
cat ~/bin/mk-data-container 
#!/usr/bin/env sh

WORKDIR="$1"

if [ -z $WORKDIR ]; then
    WORKDIR='.'
fi

cd $WORKDIR
echo "FROM debian:jessie\n\nVOLUME [ '/data' ]\n\nCOPY * /data/" > ./Dockerfile.data-container
docker rm data
docker build -f ./Dockerfile.data-container -t temp/data .
docker run --name data temp/data
rm ./Dockerfile.data-container
```

## Data container with kubectl container
```
docker run --rm -it --volumes-from data k8s/kubectl:<tag> --server=http://<server-name>:8080 create -f /data/controller.yml
```

