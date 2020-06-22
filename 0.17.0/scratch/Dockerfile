FROM scratch
COPY --from=nats-streaming:0.17.0-alpine3.11 /usr/local/bin/nats-streaming-server /nats-streaming-server
EXPOSE 4222 8222
ENTRYPOINT ["/nats-streaming-server"]
CMD ["-m", "8222"]
