die() { echo "\nERROR: $1" 1>&2 ; exit 1 ; }

ok() { echo "\nOK" 1>&2 ; }

apk_add_openssl() { 
	openssl version 2> /dev/null && return || true

	if which which 2> /dev/null; then
		if which apk; then
			apk update && apk add openssl
		elif which apt-get; then
			apt-get update && apt-get install -y openssl
		else
			die "Unable to install openssl, unknown distro"
		fi
	else
		if yum -h; then
			yum install -y openssl
		fi
	fi
}

srctype=${srctype:-certificates}
src="$(pwd)/${srctype}/src/"
cd "$(dirname $0)/../../../"

[ "$1" = "-install" ] && apk_add_openssl && shift || true
