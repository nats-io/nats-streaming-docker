#!/bin/bash

CONFIG_FILE="/etc/server.cfg"
BIN=/nats-streaming-server

if [ -f ${CONFIG_FILE}.tpl ]; then
    envtpl ${CONFIG_FILE}.tpl
    if [ $? -ne 0 ]; then
        echo "ERROR - unable to generate $CONFIG_FILE"
        exit 1
    fi
fi
if [ ! -f "${CONFIG_FILE}" ]; then
    echo "ERROR - can't find ${CONFIG_FILE}"
    exit 1
fi

if [[ "x$STORE_MODE" = "xfile" ]]; then
  STORE_OPTIONS=" -store file -dir /data"
fi
if [ "${1:0:1}" = '-' ]; then
    set -- "$BIN" --config "$CONFIG_FILE" "$@" $STORE_OPTIONS
fi

exec $@
