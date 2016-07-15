FROM alpine

MAINTAINER Lachlan Evenson <lachlan.evenson@gmail.com>

ENV KUBE_LATEST_VERSION="v1.2.6"

RUN apk add --update -t deps curl ca-certificates \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl \
 && apk del --purge deps \
 && rm /var/cache/apk/*

ENTRYPOINT ["kubectl"]
CMD ["help"]
