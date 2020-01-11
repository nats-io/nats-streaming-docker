FROM alpine:3.11 as alpine

RUN apk add -U --no-cache ca-certificates

FROM scratch

COPY --from=alpine /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY nats-streaming-server /nats-streaming-server

# Expose client and management ports
EXPOSE 4222 8222

# Run with default memory based store
ENTRYPOINT ["/nats-streaming-server"]
CMD ["-m", "8222"]
