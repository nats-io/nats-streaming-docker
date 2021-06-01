FROM alpine:3.13

ENV NATS_STREAMING_SERVER 0.22.0

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='3ffc4b74f469b97a8ce0edff8b645baf89d9f9f3debdfa7088a0ceac3ed6c37b' ;; \
		armhf) natsArch='arm6'; sha256='abe201b1a90cd2e8db39989c81a2c76d3956035745c68d0c7e090fc8c5a138c8' ;; \
		armv7) natsArch='arm7'; sha256='d218edd395f980ea91a54624b4cc1fe0220268171ee596a24d7c01c15a7dbb7f' ;; \
		x86_64) natsArch='amd64'; sha256='72f5b899167a8866d4b82d1bf9bc14b5d047e6b1ab127dd0085e9eb91a89f097' ;; \
		x86) natsArch='386'; sha256='d87bb204228c5e820747e1682dbfb56289e3ddadcfe129b9c9fcf1ad7c0ba053' ;; \
		*) echo >&2 "error: $apkArch is not supported!"; exit 1 ;; \
	esac; \
	\
	wget -O nats-streaming-server.zip "https://github.com/nats-io/nats-streaming-server/releases/download/v${NATS_STREAMING_SERVER}/nats-streaming-server-v${NATS_STREAMING_SERVER}-linux-${natsArch}.zip"; \
	echo "${sha256} *nats-streaming-server.zip" | sha256sum -c -; \
	\
	apk add --no-cache ca-certificates; \
	apk add --no-cache --virtual buildtmp unzip; \
	\
	unzip nats-streaming-server.zip "nats-streaming-server-v${NATS_STREAMING_SERVER}-linux-${natsArch}/nats-streaming-server"; \
	rm nats-streaming-server.zip; \
	mv "nats-streaming-server-v${NATS_STREAMING_SERVER}-linux-${natsArch}/nats-streaming-server" /usr/local/bin; \
	rmdir "nats-streaming-server-v${NATS_STREAMING_SERVER}-linux-${natsArch}"; \
	\
	apk del --no-cache --no-network buildtmp

COPY docker-entrypoint.sh /usr/local/bin
EXPOSE 4222 8222
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nats-streaming-server", "-m", "8222"]
