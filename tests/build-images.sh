#!/usr/bin/env bash
set -ex

ver=(NATS_STREAMING_SERVER 0.17.0)

(
	cd "${ver[1]}/alpine3.11"
	docker build --tag nats-streaming:0.17.0-alpine3.11 .
)

(
	cd "${ver[1]}/scratch"
	docker build --tag nats-streaming:0.17.0-scratch .
)
