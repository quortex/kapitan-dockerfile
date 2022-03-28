from kapicorp/kapitan:v0.30.0

ARG YQ_VERSION=v4.21.1

USER root

RUN apt-get update && apt-get install -y \
  wget \
  curl \
  && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64.tar.gz -O - | tar xz && mv yq_linux_amd64 /usr/bin/yq

RUN curl -fLSs https://raw.githubusercontent.com/CircleCI-Public/circleci-cli/master/install.sh | bash

USER kapitan

ENTRYPOINT ["kapitan"]
