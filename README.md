# nats-streaming-docker

[![License][License-Image]][License-Url]

This is the repo for building the official [NATS Streaming Server Docker images]. If you
just want to use NATS Streaming server, then head over to [Docker Hub]. You don't need
this repo.

The rest of this readme is for image maintainers.

## Directory structure

The directories are structured in a way such that each NATS server release has
a directory. Each release version has a number of base image variants, such as
scratch on Linux or nanoserver on Windows.

```
nats-streaming-docker/
├── 1.2.3
│   ├── image variant
└───└── image variant
```

For the most part, image variant Dockerfiles will download the official NATS Streaming
server [release binaries] when building the server image and `COPY` a default
configuration file.

The Linux scratch image is a little special. It copies a server binary from the
Alpine image because the scratch image doesn't come with any tools to download
and untar binaries.

## Updating NATS Streaming server version

First, make sure you've published a new NATS server git tag and make sure the
[release binaries] and SHASUMS are ready to download.

Next, run the command below. This will update the version and hash of the NATS
server.

```
usage: ./update.py <server version>
       ./update.py 0.22.1
```

You can check what changed with `git diff`.

## Manual updates

This script doesn't update everything. Here are some other things you
may or may not want to update.

* The Ubuntu host version used for CI.
* The Windows host versions used for CI.
* The Alpine version

After you've updated everything that needs updating. Submit a PR to this repo.
Make sure CI passes.

## Publishing on Docker Hub

To publish your new changes to Docker Hub. Head over to
[docker-library/official-images]. You'll need to update the [nats-streaming IMF] file.

IMF stands for Internet Message Format. It's the format that Docker chose to
declare images, instead of something like YAML.

You'll need to update the git commit in this file.

```
GitCommit: 9716618a61deba8a7e28b69d53d95d698bde5117
```

Also handy to know, if you're testing and haven't merged your PR in
nats-io/nats-streaming-docker. You can tell Docker to pull a commit from a different
branch like this.

```
GitFetch: refs/heads/mybranch
GitCommit: 9716618a61deba8a7e28b69d53d95d698bde5117
```

Docker images will be built in the order they're specified in the IMF file.
This detail is very important because Windows images and the scratch image
depend on this behavior. Nanoserver images must be built after servercore
images. Scratch must be built after Alpine.

```
Tags: 0.17.0-windowsservercore-1809, windowsservercore-1809
Architectures: windows-amd64
Directory: 0.17.0/windowsservercore-1809
Constraints: windowsservercore-1809

Tags: 0.17.0-nanoserver-1809, nanoserver-1809
Architectures: windows-amd64
Directory: 0.17.0/nanoserver-1809
Constraints: nanoserver-1809, windowsservercore-1809
```

The names of the images also have to be consistent with the rest of the
official images. Make sure the names match existing image names. For example,
it should be `0.17.0-windowsservercore-1809`, not `0.17.0-windowsservercore1809`,
not `0.17.0-servercore-1809`.


[Docker Hub]: https://hub.docker.com/_/nats-streaming
[docker-library/official-images]: https://github.com/docker-library/official-images
[License-Image]: https://img.shields.io/badge/License-Apache2-blue.svg
[License-Url]: https://www.apache.org/licenses/LICENSE-2.0
[nats-streaming IMF]: https://github.com/docker-library/official-images/blob/master/library/nats-streaming
[NATS Streaming Server Docker images]: https://hub.docker.com/_/nats-streaming
[release binaries]: https://github.com/nats-io/nats-streaming-server/releases