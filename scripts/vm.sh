#!/usr/bin/env sh

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

while [ -n "${1:-}" ]; do
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

if [ -z "${host}" ]; then
	printf '%s\n' 'Error: HOST is required.' >&2
	print_usage >&2
	exit 1
fi

shift

### MAIN ###

if [ ! -d "src/hosts/${host}" ]; then
	printf '%s\n' "Error: ${host} is not a valid host." >&2
	exit 2
fi

./scripts/build.sh "${host}-virtual-machine" || exit 3

state="$(mktemp -d)"
trap 'rm -rf "${state}"' EXIT

# Automatically use the best options for the current host, unless overridden by the user
if [ -z "${QEMU_OPTS:-}" ]; then
	if [ -n "${WAYLAND_DISPLAY:-${DISPLAY:-}}" ] && [ -z "${SSH_CONNECTION:-}" ]; then
		# Use acceleration in graphical environments
		# Use SDL instead of GTK as GTK might have issues with scaling
		QEMU_OPTS='-device virtio-vga-gl -display sdl,gl=on'
	else
		QEMU_OPTS='-device virtio-vga'
	fi
fi

NIX_DISK_IMAGE="${state}/disk.qcow2" NIX_EFI_VARS="${state}/efi-vars.fd" QEMU_OPTS="${QEMU_OPTS}" "./build/${host}-virtual-machine/bin/run-${host}-vm-vm" "$@"
