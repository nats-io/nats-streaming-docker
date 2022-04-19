FROM alpine:3.15

ENV NATS_STREAMING_SERVER 0.24.4

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='abf61454846309f4350a209aa86d8def4ceefaa35b576fe027915f31eeaaebf6' ;; \
		armhf) natsArch='arm6'; sha256='bc6efafbf051b8bbabe868240ffa9f88a5676727e3c6a5ffc13542ebd0d6585c' ;; \
		armv7) natsArch='arm7'; sha256='7950f6ea4b5385454350c8979d6062aa710400a2d21a3a44d971e8535d944545' ;; \
		x86_64) natsArch='amd64'; sha256='e7b1db559c02d123d0aabdf0d3a93803eb0778aa733a26ec9067c833bd5728b9' ;; \
		x86) natsArch='386'; sha256='941a7be15b8f3d2ba18508baaced39884b1ed86214c2afb2c2bcfcfad3743903' ;; \
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
