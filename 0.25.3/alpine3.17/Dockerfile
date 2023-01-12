FROM alpine:3.17

ENV NATS_STREAMING_SERVER 0.25.3

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='250dbab0595befb22a54804ec9be48537f22da0b6a5970e984d84c28d19f70d5' ;; \
		armhf) natsArch='arm6'; sha256='27c74e261ccd1374da227e8c31184a8e98d0820bdd916e9a681be7fba12f7f09' ;; \
		armv7) natsArch='arm7'; sha256='3db62df2019c947b54ea943ecaa5d1e34db6855247e53ec7c8ad46d0c206a6c4' ;; \
		x86_64) natsArch='amd64'; sha256='ac5beb0e820af18e422bef12200012d86237b98872e0ed48c985426315b02cbb' ;; \
		x86) natsArch='386'; sha256='887527bb48ab6029cbc1583cfd09e608148342e50e71851dbfa4c88aefb3fd39' ;; \
		*) echo >&2 "error: $apkArch is not supported!"; exit 1 ;; \
	esac; \
	\
	wget -O nats-streaming-server.tar.gz "https://github.com/nats-io/nats-streaming-server/releases/download/v${NATS_STREAMING_SERVER}/nats-streaming-server-v${NATS_STREAMING_SERVER}-linux-${natsArch}.tar.gz"; \
	echo "${sha256} *nats-streaming-server.tar.gz" | sha256sum -c -; \
	\
	apk add --no-cache ca-certificates; \
	\
	tar -xf nats-streaming-server.tar.gz; \
	rm nats-streaming-server.tar.gz; \
	mv "nats-streaming-server-v${NATS_STREAMING_SERVER}-linux-${natsArch}/nats-streaming-server" /usr/local/bin; \
	rm -rf "nats-streaming-server-v${NATS_STREAMING_SERVER}-linux-${natsArch}"

COPY docker-entrypoint.sh /usr/local/bin
EXPOSE 4222 8222
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nats-streaming-server", "-m", "8222"]
