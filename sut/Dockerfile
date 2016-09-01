From appcelerator/alpine:20160726
RUN apk update && apk upgrade && \
    apk add go>1.6 git && \
    export GOPATH=/go && \
    go get -v github.com/nats-io/nats && \
    cd $GOPATH/src/github.com/nats-io/nats && \
    cp examples/*.go /bin/

COPY ./test.sh /bin
CMD ["/bin/test.sh"]
