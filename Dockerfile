ARG BASE_IMAGE=ubuntu:latest
FROM $BASE_IMAGE

ENV DEBIAN_FRONTEND=noninteractive 
RUN mkdir /toolchain-setup
COPY ./toolchain-setup.sh /toolchain-setup/toolchain-setup.sh
RUN DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git \
    wget \
    sudo \
  && chmod +x /toolchain-setup/toolchain-setup.sh \
  && /toolchain-setup/toolchain-setup.sh env \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /opt/mxe/.ccache \
  && rm -rf /opt/mxe/pkg

ENTRYPOINT ["/toolchain-setup/toolchain-setup.sh"]
