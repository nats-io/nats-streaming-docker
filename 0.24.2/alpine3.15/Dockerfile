FROM alpine:3.15

ENV NATS_STREAMING_SERVER 0.24.2

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='8e64112ae12886aebb06422e587ebf89eecec6aef9e11a85e034b23f7ea4fba6' ;; \
		armhf) natsArch='arm6'; sha256='1550060a4f076cb3be61a10ac41252449fb645dea09df2a5eea5ee1187f93beb' ;; \
		armv7) natsArch='arm7'; sha256='29c5573fa8f1c196577d317494752496db9343b9d893db313ad3b7cc432c3480' ;; \
		x86_64) natsArch='amd64'; sha256='1db336a63b6789142fde23d2d27e210ec618c018e6cc904af7533362888d01ec' ;; \
		x86) natsArch='386'; sha256='819e4f7cb6bd408b9eab2ca193ec225aa5d48434ac1dddacd9642308e5cbdd1d' ;; \
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
