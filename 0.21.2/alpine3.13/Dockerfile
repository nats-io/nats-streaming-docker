FROM alpine:3.13

ENV NATS_STREAMING_SERVER 0.21.2

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) natsArch='arm64'; sha256='56bcfea3c3d7a232dab93ad280ce8f8df87959ac000c7d24ce03dbab2f4c4d2b' ;; \
		armhf) natsArch='arm6'; sha256='34d7032ba61724ec55d78cb94a5ed244754509b8b957e1e7e4f0579292c35a7f' ;; \
		armv7) natsArch='arm7'; sha256='b4869711408e3823c8818e934bf90d07ed51f350147702b80831fb4fe5a390d2' ;; \
		x86_64) natsArch='amd64'; sha256='7a401a3af7eb56a0d1d3b207dc517222697b48cb7e9e524848e62bd13393d23a' ;; \
		x86) natsArch='386'; sha256='58aa4cad4c75920522ec0457b79d889f9c740c248647b875254cd1313517620c' ;; \
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
