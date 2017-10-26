FROM microsoft/windowsservercore

# The NAT Streaming Server will look for this environment variable.
# When set, it prevents the use of the service API to detect
# if it is running in interactive mode or not, which is
# failing in the context of a Docker container.
# (https://github.com/nats-io/gnatsd/issues/543)
ENV NATS_DOCKERIZED=1

WORKDIR c:/nats-streaming-server
COPY nats-streaming-server.exe nats-streaming-server.exe

# Expose client and management ports
EXPOSE 4222 8222

# Run with default memory based store 
CMD ["nats-streaming-server", "-m", "8222"]
