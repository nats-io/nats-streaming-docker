FROM scratch

COPY nats-streaming-server /nats-streaming-server

# Expose client, route and management ports
EXPOSE 4222 5222 8222

# Run with default memory based store
ENTRYPOINT ["/nats-streaming-server"]
CMD ["-m", "8222"]
