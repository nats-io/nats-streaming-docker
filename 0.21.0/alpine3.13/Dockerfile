FROM alpine:3.13

ENV NATS_STREAMING_SERVER 0.21.0

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='ace8ba06da52ca4254236c3385f07a0270bb0155139c71f853a8ca97c816880e' ;; \
		armhf) natsArch='arm6'; sha256='769cab28925287d6ce3d67912799273c2ca417684adc09db2529d3e64ffdc10f' ;; \
		armv7) natsArch='arm7'; sha256='f4adcefd1f9e1d6d6e9b9fb437b25ef245851b9a26d5cd29def3afff6db4b896' ;; \
		x86_64) natsArch='amd64'; sha256='b259633f4f6680b0f6af96b856b648b28970e5d0f2cfc38a439ea07b9bbe2a1d' ;; \
		x86) natsArch='386'; sha256='cfb14ae3ab52e66d85e83b2a35f3daee7b9e8fee031a24aeef801f128398e57a' ;; \
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
