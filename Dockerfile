# Do not upgrade kapitan until performance issues are resolved
FROM kapicorp/kapitan:0.34.6
ARG TARGETOS
ARG TARGETARCH

ARG YQ_VERSION=v4.44.5
ARG YTT_VERSION=v0.51.0
ARG CIRCLECI_CLI_VERSION=0.1.30995
ARG TERRAFORM_DOCS_VERSION=v0.19.0
ARG RJSONNET_VERSION=0.5.4

USER root

RUN apt-get update && apt-get install -y \
  curl \
  && rm -rf /var/lib/apt/lists/*

RUN curl -fLSs https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_${TARGETOS}_${TARGETARCH}.tar.gz | \
  tar xz && mv yq_${TARGETOS}_${TARGETARCH} /usr/bin/yq

RUN curl -fLSs https://github.com/carvel-dev/ytt/releases/download/${YTT_VERSION}/ytt-${TARGETOS}-${TARGETARCH} --output /usr/bin/ytt && \
  chmod +x /usr/bin/ytt

RUN curl -fLSs https://raw.githubusercontent.com/CircleCI-Public/circleci-cli/master/install.sh | \
  VERSION=${CIRCLECI_CLI_VERSION} bash

RUN curl -fLSs ./terraform-docs.tar.gz https://github.com/terraform-docs/terraform-docs/releases/download/${TERRAFORM_DOCS_VERSION}/terraform-docs-${TERRAFORM_DOCS_VERSION}-${TARGETOS}-${TARGETARCH}.tar.gz | \
  tar xz && chmod +x terraform-docs && \
  mv terraform-docs /usr/bin/terraform-docs

RUN pip install rjsonnet==${RJSONNET_VERSION}

USER kapitan

ENTRYPOINT ["kapitan"]
