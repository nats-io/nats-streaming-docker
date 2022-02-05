FROM alpine:3.15

ENV NATS_STREAMING_SERVER 0.24.1

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='4f523a0562e61b46965ab7ebf0a0a84eced6152c43a85b04d4820afa4630fd4a' ;; \
		armhf) natsArch='arm6'; sha256='cfc10c9c58325b862f38b4c1c08ee492d05cdf4e848aa24068dd8aeb083abda5' ;; \
		armv7) natsArch='arm7'; sha256='e72a91c6904bf42641e1737c3529c220ff93b34f055c7379a0bbdc7ba1529b9b' ;; \
		x86_64) natsArch='amd64'; sha256='8c5ec55312c1cb322aacfb249dbde04e429df5de57952210f82caf825e93f159' ;; \
		x86) natsArch='386'; sha256='4ccf5aa57f33df9591fcce8a1737eb63c71070d09c1a3c098c27865b42803dea' ;; \
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
