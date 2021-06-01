#!/usr/bin/env bash
set -ex

ver=(NATS_STREAMING_SERVER 0.22.0)

(
	cd "${ver[1]}/alpine3.13"
	docker build --tag nats-streaming:0.22.0-alpine3.13 .
)

(
	cd "${ver[1]}/scratch"
	docker build --tag nats-streaming:0.22.0-scratch .
)
