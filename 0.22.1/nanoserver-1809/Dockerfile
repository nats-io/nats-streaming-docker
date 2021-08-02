FROM mcr.microsoft.com/windows/nanoserver:1809

# The NAT Streaming Server will look for this environment variable.
# When set, it prevents the use of the service API to detect
# if it is running in interactive mode or not, which is
# failing in the context of a Docker container.
# (https://github.com/nats-io/gnatsd/issues/543)
ENV NATS_DOCKERIZED 1

COPY --from=nats-streaming:0.22.0-windowsservercore-1809 C:\\nats-streaming-server.exe C:\\nats-streaming-server.exe

EXPOSE 4222 8222
ENTRYPOINT ["C:\\nats-streaming-server.exe"]
CMD ["-m", "8222"]
