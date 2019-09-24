FROM bitnami/minideb
RUN sed -ri 's/archive/nz.\0/g' /etc/apt/sources.list
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
	&& apt-get install -y --no-install-recommends git gcc-8-arm-linux-gnueabi \
	binutils-arm-linux-gnueabi make \
	libc6-dev-armel-cross \
	&& apt-get autoclean && apt-get clean \
	&& rm -rf /var/lib/apt/lists \
	&& rm -rf /var/cache/apt/archives
RUN useradd -u 1000 builder -d /src
USER builder
WORKDIR /src
CMD make ARCH=arm
