# Kubernetes Client

[![](https://images.microbadger.com/badges/image/lachlanevenson/k8s-kubectl.svg)](http://microbadger.com/images/lachlanevenson/k8s-kubectl "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/lachlanevenson/k8s-kubectl.svg)](http://microbadger.com/images/lachlanevenson/k8s-kubectl "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/commit/lachlanevenson/k8s-kubectl.svg)](http://microbadger.com/images/lachlanevenson/k8s-kubectl "Get your own commit badge on microbadger.com")

# Supported tags and respective `Dockerfile` links
* `1.4.0`, `latest`    [(1.4.0/Dockerfile)](https://github.com/lachie83/k8s-kubectl/blob/v1.4.0/Dockerfile)
* `1.3.7`,     [(1.3.7/Dockerfile)](https://github.com/lachie83/k8s-kubectl/blob/v1.3.7/Dockerfile)
* `1.2.6`,     [(1.2.6/Dockerfile)](https://github.com/lachie83/k8s-kubectl/blob/v1.2.6/Dockerfile)
* `1.1.8`,     [(1.1.8/Dockerfile)](https://github.com/lachie83/k8s-kubectl/blob/v1.1.8/Dockerfile)
* `1.0.7`,     [(1.0.7/Dockerfile)](https://github.com/lachie83/k8s-kubectl/blob/v1.0.7/Dockerfile)


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

