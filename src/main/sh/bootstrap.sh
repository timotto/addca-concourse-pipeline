#!/bin/sh -e

[ -n "$1" ] && build="$(pwd)/$1" || build=""
. "$(dirname "$0")/common.sh"

[ -z "$build" ] && build="build" || true
[ -d "$build" ] || mkdir -p "$build"

cat src/main/concourse/pipeline.template.yaml | \
	sed -e's/_JOBS_//' -e's/_RESOURCES_//' \
> "${build}/pipeline.yaml"
