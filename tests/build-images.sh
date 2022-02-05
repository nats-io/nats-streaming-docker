#!/usr/bin/env bash
set -ex

ver=(NATS_STREAMING_SERVER 0.24.1)

(
	cd "${ver[1]}/alpine3.15"
	docker build --tag nats-streaming:0.24.1-alpine3.15 .
)

(
	cd "${ver[1]}/scratch"
	docker build --tag nats-streaming:0.24.1-scratch .
)
