from kapicorp/kapitan:v0.31.1-rc.3
ARG TARGETOS
ARG TARGETARCH

ARG YQ_VERSION=v4.21.1
ARG CIRCLECI_CLI_VERSION=0.1.26837
ARG TERRAFORM_DOCS_VERSION=v0.16.0

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

USER kapitan

ENTRYPOINT ["kapitan"]
