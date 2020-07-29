FROM alpine:3.12

ENV NATS_STREAMING_SERVER 0.18.0

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64|arm64) natsArch='arm64'; sha256='ff2a51618b79685264f980fe868f1c7af583c419b6406cc63d4811f3c98ca8fe' ;; \
		armhf) natsArch='arm6'; sha256='629e17255f12fd80e051772a6dd18a7f65e692b4abef0786b421eb8b6ab85db4' ;; \
		armv7) natsArch='arm7'; sha256='94e499af6a6391519315e8bcd5127c43c1d1a442ef945956286e77b4366c92c9' ;; \
		x86_64) natsArch='amd64'; sha256='6252e9262efc81a41ade3f43b68e014d1e635d3e3bf9cbcd2b09c3a030a0d5e6' ;; \
		x86) natsArch='386'; sha256='886ebd2e5eb99e30ff9e9d8907d7bd49dafacffce1dc921427e5754a4ec26f55' ;; \
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
