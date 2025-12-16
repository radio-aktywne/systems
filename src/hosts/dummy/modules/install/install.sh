#!/usr/bin/env bash

### CONFIGURATION ###

FLAKE='@flake@'
HOST='@host@'
KEYS_FILE='@keysFile@'
MAIN_DISK_DEVICE='@mainDiskDevice@'

### HELPER FUNCTIONS ###

print_usage() {
	# Print script usage

	cat <<EOF
Usage: $0 [-k KEYSFILE] [OPTIONS]
Install the system on this machine.

	-k, --keysfile           path to the age keys file
EOF
}

### PARSE ARGUMENTS ###

keysfile="${SOPS_AGE_KEY_FILE:-${SOPS_AGE_KEY_DIR:-${XDG_CONFIG_HOME:-${HOME}/.config/}/sops/age/}/keys.txt}"
unparsed=''

while [[ -n ${1:-} ]]; do
	case "$1" in
	-k | --keysfile)
		shift
		keysfile="$1"
		;;
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

if [[ ! -e ${keysfile} ]]; then
	printf '%s\n' "Error: Keys file ${keysfile} does not exist." >&2
	print_usage >&2
	exit 1
fi

### MAIN ###

disko-install \
	--flake "${FLAKE}#${HOST}" \
	--disk main "${MAIN_DISK_DEVICE}" \
	--extra-files "${keysfile}" "${KEYS_FILE}" \
	--write-efi-boot-entries \
	"$@"
