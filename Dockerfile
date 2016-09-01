FROM appcelerator/alpine:20160726

ENV NATS_VERSION 0.2.2
RUN apk update && apk upgrade && \
    apk --virtual build-deps add go>1.6 curl git gcc musl-dev && \
    export GOPATH=/go && \
    go get -v github.com/nats-io/nats-streaming-server && \
    cd $GOPATH/src/github.com/nats-io/nats-streaming-server && \
    git checkout -q --detach "v${NATS_VERSION}" && \
    go get -v  ./... && \
    CGO_ENABLED=0 go install -v -a -ldflags "-s -w -X github.com/nats-io/nats-streaming-server/version.GITCOMMIT=`git rev-parse --short HEAD`" && \
    chmod +x $GOPATH/bin/nats-streaming-server && \
    cp $GOPATH/bin/nats-streaming-server / && \
    mkdir -p /data && \
    apk del build-deps && cd / && rm -rf $GOPATH/ /var/cache/apk/*

# Expose client and management ports
EXPOSE 4222 6222 8222

COPY run.sh /
COPY server.cfg /etc/server.cfg.tpl

VOLUME ["/data"]

HEALTHCHECK --interval=5s --retries=3 --timeout=1s CMD curl -sI localhost:8222 | grep -q "HTTP/1.1 200 OK"

# Run with default memory based store 
ENTRYPOINT ["/run.sh"]
CMD ["-m", "8222"]
