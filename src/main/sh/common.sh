die() { echo "\nERROR: $1" 1>&2 ; exit 1 ; }

ok() { echo "\nOK" 1>&2 ; }

cd "$(dirname $0)/../../../"
