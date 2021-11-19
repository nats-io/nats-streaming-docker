FROM alpine:3.14

ENV NATS_STREAMING_SERVER 0.23.2

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='623cd04855e16ca52694964e01e3b50ded9747a45885bba1a705513da297f6fd' ;; \
		armhf) natsArch='arm6'; sha256='fd40f251da335eb7b3cc63b08f8bc0a80d3a4df10fec4efdf6e60417248a5287' ;; \
		armv7) natsArch='arm7'; sha256='83db867570654731de98f135f9f373d0758bd9c5a3ee304b65c8128e1d928023' ;; \
		x86_64) natsArch='amd64'; sha256='d0c5ebc16901bdc4788d0382dab6f7ce69582e1bafea3ddba159b38ae87b6c81' ;; \
		x86) natsArch='386'; sha256='8b9c5396a7747abc8415dc8ca915cf6cb2fd1b79b64ce7a4c3f5efb241cd389f' ;; \
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
