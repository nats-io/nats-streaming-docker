FROM alpine:3.15

ENV NATS_STREAMING_SERVER 0.24.5

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='1cc0aa6328b4844aa22accaf8dbb0cb2624c7feae6b27a1a64f7da4dd86c1cda' ;; \
		armhf) natsArch='arm6'; sha256='a691dc15fdb17d6d1d69f108d72c6a28d2151fa6abbddb2823c1624792b77c2c' ;; \
		armv7) natsArch='arm7'; sha256='e93e783e2b89ca340fe623b5575375eb792de3b5ac180023f318faed8e648a58' ;; \
		x86_64) natsArch='amd64'; sha256='d368b2cbc60fb37316ad139b978a5c830ba2400affd56910ecc9b363d16e0663' ;; \
		x86) natsArch='386'; sha256='d553dc387e91573b8d3b7093039d9cc1392c95863bf20027c3ff4350a0cd9890' ;; \
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
