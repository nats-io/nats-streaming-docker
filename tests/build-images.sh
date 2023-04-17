#!/usr/bin/env bash
set -ex

ver=(NATS_STREAMING_SERVER 0.25.4)

(
	cd "${ver[1]}/alpine3.17"
	docker build --tag nats-streaming:0.25.4-alpine3.17 .
)

(
	cd "${ver[1]}/scratch"
	docker build --tag nats-streaming:0.25.4-scratch .
)
