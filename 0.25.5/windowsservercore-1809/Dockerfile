FROM mcr.microsoft.com/windows/servercore:1809

# Enable exit on error.
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

ENV NATS_DOCKERIZED 1
ENV NATS_STREAMING_SERVER 0.25.5
ENV NATS_STREAMING_SERVER_DOWNLOAD https://github.com/nats-io/nats-streaming-server/releases/download/v${NATS_STREAMING_SERVER}/nats-streaming-server-v${NATS_STREAMING_SERVER}-windows-amd64.zip
ENV NATS_STREAMING_SERVER_SHASUM 709b481bfa3537dc7941490365e065554f19c7029830d765ef49e8cd16657b75

RUN Set-PSDebug -Trace 2

RUN Write-Host ('downloading from {0} ...' -f $env:NATS_STREAMING_SERVER_DOWNLOAD); \
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; \
	Invoke-WebRequest -Uri $env:NATS_STREAMING_SERVER_DOWNLOAD -OutFile nats-streaming.zip; \
	\
	Write-Host ('verifying sha256 ({0}) ...' -f $env:NATS_STREAMING_SERVER_SHASUM); \
	if ((Get-FileHash nats-streaming.zip -Algorithm sha256).Hash -ne $env:NATS_STREAMING_SERVER_SHASUM) { \
		Write-Host 'FAILED!'; \
		exit 1; \
	}; \
	Write-Host 'extracting nats-streaming.zip'; \
	Expand-Archive -Path 'nats-streaming.zip' -DestinationPath .; \
	\
	Write-Host 'copying binary'; \
	Copy-Item nats-streaming-server-v*/nats-streaming-server.exe -Destination C:\\nats-streaming-server.exe; \
	\
	Write-Host 'cleaning up'; \
	Remove-Item -Force nats-streaming.zip; \
	Remove-Item -Recurse -Force nats-streaming-server-v*; \
	\
	Write-Host 'complete.';

EXPOSE 4222 8222
ENTRYPOINT ["C:\\nats-streaming-server.exe"]
CMD ["-m", "8222"]
