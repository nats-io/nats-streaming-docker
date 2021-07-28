FROM alpine:3.14

ENV NATS_STREAMING_SERVER 0.22.0

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='2f16881c99a0b44a271bd8a0db2d422757d1e25667625c9e813786a07bc9942b' ;; \
		armhf) natsArch='arm6'; sha256='f135bb54648e2fd1cb4183b41bef99cf466d6808fd5cd6cb8d084b6615a73f28' ;; \
		armv7) natsArch='arm7'; sha256='015c71dababf14b710aa5d9ab4339d006ddfa2761c01b46a5a3022c1a7f9d207' ;; \
		x86_64) natsArch='amd64'; sha256='30c7767ff1f9028d5b3236dac6923909f9da4fc5faaadc41efafbf9bad4b949e' ;; \
		x86) natsArch='386'; sha256='deb917e5b49b1871be5469b057b0bfe10543bc716324bb14341e12b1b65942b6' ;; \
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
