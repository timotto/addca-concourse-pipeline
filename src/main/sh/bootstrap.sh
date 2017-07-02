#!/bin/sh -e

[ -n "$1" ] && build="$(pwd)/$1" || build=""
. "$(dirname "$0")/common.sh"

[ -z "$build" ] && build="build" || true
[ -d "$build" ] || mkdir -p "$build"

cat src/main/concourse/pipeline.template.yaml | \
	sed -e's/_JOBS_//' -e's/_RESOURCES_//' \
> "${build}/pipeline.yaml"

if [ -f "${build}/secrets.yaml" ]; then
	echo "please check ${build}/secrets.yaml and secrets.example.yaml for any new variables"
else
	cat secrets.example.yaml > "${build}/secrets.yaml"
	echo "please edit ${build}/secrets.yaml"
fi
echo "then run 'fly -t target set-pipeline -p addca -c ${build}/pipeline.yaml -l ${build}/secrets.yaml'"
