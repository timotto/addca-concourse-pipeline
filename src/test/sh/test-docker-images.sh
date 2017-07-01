#!/bin/sh -ex

srctype=docker-images
. "$(dirname "$0")/common.sh"

[ -f "${src}/docker-images.txt" ] || die "file src/docker-images.txt not found"
hits=0
while read image tag flavor; do
	hits=$(($hits + 1))
	case "$flavor" in
		alpine|debian|rhel) break ;;
		*) die "unknown flavor: $flavor" ;;
	esac
done < "${src}/docker-images.txt"
