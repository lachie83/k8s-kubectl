# Kubernetes Client

## Overview
This container provides the Kubernetes client kubectl which can be used to interact with a Kubernetes cluster

## Build
`docker build -t levenson/kubectl:1.0.3 .`

## Run
`docker run --rm levenson/kubectl:1.0.3 --server=http://<server-name>:8080 get pods`

