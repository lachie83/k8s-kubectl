FROM ubuntu:14.04

MAINTAINER Lachlan Evenson <lachlan.evenson@gmail.com>

ENV SVC_ROOT=/opt/bin
ENV KUBE_LATEST_VERSION="v1.1.2"
ENV KUBE_LATEST_URL="https://github.com/kubernetes/kubernetes/releases/download/${KUBE_LATEST_VERSION}/kubernetes.tar.gz"

RUN apt-get install -y wget zip && apt-get clean && apt-get purge
RUN mkdir -p ${SVC_ROOT}

WORKDIR ${SVC_ROOT}

RUN wget -O ${SVC_ROOT}/kubernetes-latest.tar.gz $KUBE_LATEST_URL && tar xzvf ${SVC_ROOT}/kubernetes-latest.tar.gz && rm -f ${SVC_ROOT}/kubernetes-latest.tar.gz && tar xzvf ${SVC_ROOT}/kubernetes/server/kubernetes-server-linux-amd64.tar.gz && mv ${SVC_ROOT}/kubernetes ${SVC_ROOT}/kubernetes-latest && cp ${SVC_ROOT}/kubernetes-latest/server/bin/kubectl ${SVC_ROOT}/ && rm -rf ${SVC_ROOT}/kubernetes-latest

ENTRYPOINT ["/opt/bin/kubectl"]
CMD ["help"]

