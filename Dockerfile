FROM alpine as builder

RUN apk update && apk add curl tar bash

ENV KUSTOMIZE_VERSION="v3.5.4"

WORKDIR /kustomize
RUN curl -s https://api.github.com/repos/kubernetes-sigs/kustomize/releases |\
    grep browser_download |\
    grep linux |\
    cut -d '"' -f 4 |\
    grep /kustomize/v  |\
    grep $KUSTOMIZE_VERSION |\
    sort | tail -n 1 |\
    xargs curl -s -O -L

RUN tar xvzf *kustomize_v*

FROM alpine

LABEL maintainer="Lachlan Evenson <lachlan.evenson@gmail.com>"

ARG VCS_REF
ARG BUILD_DATE

# Metadata
LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/lachie83/k8s-kubectl" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.docker.dockerfile="/Dockerfile"

COPY --from=builder /kustomize/kustomize /usr/local/bin
RUN chmod +x /usr/local/bin/kustomize

ENV KUBE_LATEST_VERSION="v1.18.6"

RUN apk add --update ca-certificates \
 && apk add --update -t deps curl \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl \
 && apk del --purge deps \
 && rm /var/cache/apk/*

WORKDIR /root
ENTRYPOINT ["kubectl"]
CMD ["help"]
