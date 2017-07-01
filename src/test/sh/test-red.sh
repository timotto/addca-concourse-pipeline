#!/bin/sh -ex

# Expect all certificates in src/test/pem to fail verification

. "$(dirname "$0")/common.sh"

for main in ${src}/main/*.crt; do
	name="$(basename "$main")"
	test="${src}/test/$name"
	[ -f "$test" ] || die "no test pem for $name"
	# make sure the test file is not verifiable without the main file
	openssl verify < "$test" && die "$name test file is verifiable by default" || true
done

ok
