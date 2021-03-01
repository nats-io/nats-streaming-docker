FROM mcr.microsoft.com/windows/servercore:ltsc2016

# Enable exit on error.
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

ENV NATS_DOCKERIZED 1
ENV NATS_STREAMING_SERVER 0.21.0
ENV NATS_STREAMING_SERVER_DOWNLOAD https://github.com/nats-io/nats-streaming-server/releases/download/v${NATS_STREAMING_SERVER}/nats-streaming-server-v${NATS_STREAMING_SERVER}-windows-amd64.zip
ENV GIT_DOWNLOAD_SHA256 00bd52804208a52014f518836198a3ebcd513fc5029eda9de2b4ef846f5cb828

RUN Set-PSDebug -Trace 2

RUN Write-Host ('downloading from {0} ...' -f $env:NATS_STREAMING_SERVER_DOWNLOAD); \
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; \
	Invoke-WebRequest -Uri $env:NATS_STREAMING_SERVER_DOWNLOAD -OutFile nats-streaming.zip; \
	\
	Write-Host ('verifying sha256 ({0}) ...' -f $env:GIT_DOWNLOAD_SHA256); \
	if ((Get-FileHash nats-streaming.zip -Algorithm sha256).Hash -ne $env:GIT_DOWNLOAD_SHA256) { \
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
