# Kubernetes Client

## Overview
This container provides the Kubernetes client kubectl which can be used to interact with a Kubernetes cluster

## Build
`docker build -t k8s/kubectl:<tag> .`

## Run
`docker run --rm k8s/kubectl:<tag> --server=http://<server-name>:8080 get pods`

