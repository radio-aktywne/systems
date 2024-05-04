#!/usr/bin/env bash

### HELPER FUNCTIONS ###

print_usage() {
	# Print script usage

	cat <<EOF
Usage: $0 TARGET [OPTIONS]
Run the specified target.
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

target="$1"

if [[ -z ${target} ]]; then
	printf '%s\n' 'Error: TARGET is required.' >&2
	print_usage >&2
	exit 1
fi

shift

### MAIN ###

nix \
	--accept-flake-config \
	--extra-experimental-features \
	'nix-command flakes' \
	--no-warn-dirty \
	run \
	".#${target}" \
	"$@"
