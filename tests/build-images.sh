#!/usr/bin/env bash
set -ex

ver=(NATS_STREAMING_SERVER 0.18.0)

(
	cd "${ver[1]}/alpine3.12"
	docker build --tag nats-streaming:0.18.0-alpine3.12 .
)

(
	cd "${ver[1]}/scratch"
	docker build --tag nats-streaming:0.18.0-scratch .
)
