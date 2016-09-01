# NATS streaming

Docker image for [nats](https://registry.hub.docker.com/_/nats-streaming/).

## Usage
To create the image `appcelerator/nats-streaming`, execute the following command in this folder:

    docker build -t appcelerator/nats-streaming .

You can now push new image to the registry:

    docker push appcelerator/nats-streaming


## Running your nats-streaming image

Start your image binding the external ports `4222` and `8222` in all interfaces to your container.

    docker run -d -p 4222:4222 -p 8222:8222 appcelerator/nats-streaming

## Configuration (ENV, -e)

Variable | Description | Default value | Sample value 
-------- | ----------- | ------------- | ------------
STORE_MODE | NATS store mode | memory | file
MAX_CONNECTIONS | Max connections | 100 |
MAX_CONTROL_LINE | Maximum protocol control line | 512 |
MAX_PAYLOAD | Maximum payload | 65536 |
MAX_PENDING_SIZE | Slow consumer threshold | 10000000 |

## Tags

- `0.2`, `0.2.2`, `latest`
