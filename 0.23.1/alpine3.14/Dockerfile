FROM alpine:3.14

ENV NATS_STREAMING_SERVER 0.23.1

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='1ae3356d830c22a1367ea4ba45f1d2868307c4c8deae13f9e89f0d1731a8fec7' ;; \
		armhf) natsArch='arm6'; sha256='961f7f622ef790f909ce7e0521054a7ff1ffa7faaea0e0ca784855b0276fba93' ;; \
		armv7) natsArch='arm7'; sha256='61992a8fae5617b14152bdb7d03e2379b8b7cd12b22c46fb7b37ffbe29cb75e7' ;; \
		x86_64) natsArch='amd64'; sha256='34cc0d6ed58c8917aa432832afd25bb89ba9ea62ea595cec1846b014a659e4af' ;; \
		x86) natsArch='386'; sha256='38fe4b22245a840279967520f9340a741ee0eea7a0fbe99a907a6a36041d323d' ;; \
		*) echo >&2 "error: $apkArch is not supported!"; exit 1 ;; \
	esac; \
	\
	wget -O nats-streaming-server.tar.gz "https://github.com/nats-io/nats-streaming-server/releases/download/v${NATS_STREAMING_SERVER}/nats-streaming-server-v${NATS_STREAMING_SERVER}-linux-${natsArch}.tar.gz"; \
	echo "${sha256} *nats-streaming-server.tar.gz" | sha256sum -c -; \
	\
	apk add --no-cache ca-certificates; \
	apk add --no-cache --virtual buildtmp; \
	\
	tar -xf nats-streaming-server.tar.gz; \
	rm nats-streaming-server.tar.gz; \
	mv "nats-streaming-server-v${NATS_STREAMING_SERVER}-linux-${natsArch}/nats-streaming-server" /usr/local/bin; \
	rm -rf "nats-streaming-server-v${NATS_STREAMING_SERVER}-linux-${natsArch}"; \
	\
	apk del --no-cache --no-network buildtmp

COPY docker-entrypoint.sh /usr/local/bin
EXPOSE 4222 8222
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nats-streaming-server", "-m", "8222"]
