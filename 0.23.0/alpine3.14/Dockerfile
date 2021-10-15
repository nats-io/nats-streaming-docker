FROM alpine:3.14

ENV NATS_STREAMING_SERVER 0.23.0

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='997b1235349360c46d37588047f5b1b64e7a8603b84478edf153124f3a0b6fbf' ;; \
		armhf) natsArch='arm6'; sha256='127e953a64ba7d88039cf7d688a29f968cadcac2a65e43bf2c93e4055665358f' ;; \
		armv7) natsArch='arm7'; sha256='d5f9bf496419f4874c2a10a668d04a858d269aec1b31306e1289ccb12b03217e' ;; \
		x86_64) natsArch='amd64'; sha256='4695eca8dbc09c1e363b5e2725eada3a1412a3a71f002ce1208aaab91c03e3d1' ;; \
		x86) natsArch='386'; sha256='b6c06a9b1edf69cfa764bc499302d27127212787bbc107045f814ad378eaed49' ;; \
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
