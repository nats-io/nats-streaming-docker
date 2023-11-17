#!/usr/bin/env bash
set -ex

ver=(NATS_STREAMING_SERVER 0.25.6)

(
	cd "${ver[1]}/alpine3.18"
	docker build --tag nats-streaming:0.25.6-alpine3.18 .
)

(
	cd "${ver[1]}/scratch"
	docker build --tag nats-streaming:0.25.6-scratch .
)
