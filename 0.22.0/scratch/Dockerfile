FROM scratch
COPY --from=nats-streaming:0.22.0-alpine3.13 /usr/local/bin/nats-streaming-server /nats-streaming-server
EXPOSE 4222 8222
ENTRYPOINT ["/nats-streaming-server"]
CMD ["-m", "8222"]
