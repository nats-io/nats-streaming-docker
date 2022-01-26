FROM alpine:3.15

ENV NATS_STREAMING_SERVER 0.24.0

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='30cfc19cbc65437a0766c0660433282c410e013500bd27eef8c642f2edccce39' ;; \
		armhf) natsArch='arm6'; sha256='c9a2df743ff09b2cb69ebce3f83c5ea8b62dfff7c64590445f4762633e9d8b70' ;; \
		armv7) natsArch='arm7'; sha256='ebebef3f5be432dbfeb691e21f4752d153c00b5323d1ecd41b485ee4582fb7c9' ;; \
		x86_64) natsArch='amd64'; sha256='c0be4d653df64ba698a747c1a255808c993226f1e703fc309c4a35a74e491cd6' ;; \
		x86) natsArch='386'; sha256='27bcb3cde323f5b1e1e56bb09a97c4290ff71df7f5343ac8ad994c3335f24c29' ;; \
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
