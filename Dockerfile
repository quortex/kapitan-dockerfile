from kapicorp/kapitan:v0.30.0

ARG YQ_VERSION=v4.21.1

USER root

RUN apt-get update && apt-get install -y \
  wget \
  && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64.tar.gz -O - | tar xz && mv yq_linux_amd64 /usr/bin/yq

USER kapitan

ENTRYPOINT ["kapitan"]
