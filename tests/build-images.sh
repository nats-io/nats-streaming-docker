#!/usr/bin/env bash
set -ex

ver=(NATS_STREAMING_SERVER 0.25.2)

(
	cd "${ver[1]}/alpine3.16"
	docker build --tag nats-streaming:0.25.2-alpine3.16 .
)

(
	cd "${ver[1]}/scratch"
	docker build --tag nats-streaming:0.25.2-scratch .
)
