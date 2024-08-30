FROM kapicorp/kapitan:0.33.0
ARG TARGETOS
ARG TARGETARCH

ARG YQ_VERSION=v4.44.3
ARG CIRCLECI_CLI_VERSION=0.1.30995
ARG TERRAFORM_DOCS_VERSION=v0.18.0
ARG RJSONNET_VERSION=0.5.4

USER root

RUN apt-get update && apt-get install -y \
  curl \
  && rm -rf /var/lib/apt/lists/*

RUN curl -fLSs https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_${TARGETOS}_${TARGETARCH}.tar.gz | \
  tar xz && mv yq_${TARGETOS}_${TARGETARCH} /usr/bin/yq

RUN curl -fLSs https://raw.githubusercontent.com/CircleCI-Public/circleci-cli/master/install.sh | \
  VERSION=${CIRCLECI_CLI_VERSION} bash

RUN curl -fLSs ./terraform-docs.tar.gz https://github.com/terraform-docs/terraform-docs/releases/download/${TERRAFORM_DOCS_VERSION}/terraform-docs-${TERRAFORM_DOCS_VERSION}-${TARGETOS}-${TARGETARCH}.tar.gz | \
  tar xz && chmod +x terraform-docs && \
  mv terraform-docs /usr/bin/terraform-docs

RUN pip install rjsonnet==${RJSONNET_VERSION}

USER kapitan

ENTRYPOINT ["kapitan"]
