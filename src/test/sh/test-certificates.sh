#!/bin/sh -ex

. "$(dirname "$0")/common.sh"

mkdir -p build/test

for main in ${src}/main/*.crt; do
	name="$(basename "$main")"
	test="${src}/test/$name"
	trust="${test}.trust"
	tmp="build/test/$name"
	[ -f "$test" ] || die "no test file for $name"
	#[ -f "$trust" ] || trust=""
	# make sure the test file is not verifiable without the main file
	openssl verify < "$test" && die "$name test file is verifiable by default" || true
	# make sure the main file makes the test file verifiable
	( [ -f "$trust" ] && cat "$main" "$trust" || cat "$main" ) > "$tmp"
	openssl verify -CAfile "$tmp" < "$test" || die "$name test file is not verifiable by provided ca file"
done

ok
