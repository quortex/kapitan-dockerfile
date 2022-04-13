from kapicorp/kapitan:v0.30.0

ARG YQ_VERSION=v4.21.1
ARG CIRCLECI_CLI_VERSION=0.1.16947
ARG TERRAFORM_DOCS_VERSION=v0.16.0

USER root

RUN apt-get update && apt-get install -y \
  wget \
  curl \
  && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64.tar.gz -O - | tar xz && mv yq_linux_amd64 /usr/bin/yq

RUN curl -fLSs https://raw.githubusercontent.com/CircleCI-Public/circleci-cli/master/install.sh | VERSION=${CIRCLECI_CLI_VERSION} bash

RUN curl -Lo ./terraform-docs.tar.gz https://github.com/terraform-docs/terraform-docs/releases/download/${TERRAFORM_DOCS_VERSION}/terraform-docs-${TERRAFORM_DOCS_VERSION}-$(uname)-amd64.tar.gz && \
  tar -xzf terraform-docs.tar.gz && \
  chmod +x terraform-docs && \
  mv terraform-docs /usr/bin/terraform-docs

USER kapitan

ENTRYPOINT ["kapitan"]
