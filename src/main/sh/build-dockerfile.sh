#!/bin/sh -ex

# Build a Dockerfile

. "$(dirname "$0")/common.sh"

cat "src/main/docker/Dockerfile.${FLAVOR}.template" | \
	sed -e's^_SOURCE_^'"${IMAGE}:${TAG}"'^'
