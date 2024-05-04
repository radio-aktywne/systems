#!/usr/bin/env bash

### HELPER FUNCTIONS ###

print_usage() {
	# Print script usage

	cat <<EOF
Usage: $0 HOST [OPTIONS]
Run a virtual machine for the specified host.
EOF
}

### PARSE ARGUMENTS ###

unparsed=''

while [[ -n ${1:-} ]]; do
	case "$1" in
	-h | --help)
		print_usage >&2
		exit
		;;
	--)
		shift
		unparsed="${unparsed} $*"
		break
		;;
	*) unparsed="${unparsed} $1" ;;
	esac
	shift
done

# shellcheck disable=SC2086
set -- ${unparsed}

host="$1"

if [[ -z ${host} ]]; then
	printf '%s\n' 'Error: HOST is required.' >&2
	print_usage >&2
	exit 1
fi

shift

### MAIN ###

if [[ ! -d "src/hosts/${host}" ]]; then
	printf '%s\n' "Error: ${host} is not a valid host." >&2
	exit 2
fi

./scripts/run.sh "${host}-virtual-machine" -- "$@"
