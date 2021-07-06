ARG BASE_IMAGE=ubuntu:latest
FROM $BASE_IMAGE

ENV DEBIAN_FRONTEND=noninteractive 
ENV TZ=Europe/London
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN mkdir /toolchain-setup
COPY ./toolchain-setup.sh /toolchain-setup/toolchain-setup.sh
RUN apt-get update && apt-get install -y \
    git \
    wget \
    sudo \
  && chmod +x /toolchain-setup/toolchain-setup.sh \
  && /toolchain-setup/toolchain-setup.sh env \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /opt/mxe/.ccache \
  && rm -rf /opt/mxe/pkg

ENTRYPOINT ["/toolchain-setup/toolchain-setup.sh"]
