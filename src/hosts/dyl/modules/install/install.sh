#!/bin/sh

### CONFIGURATION ###

# Don't try to make the script self-contained
# Just assume some binaries are already available
# First, this reduces the size down
# Second, some things need to be compatible with the host system

BOOT='@boot@'
DISK_A='@diskA@'
DISK_B='@diskB@'
FLAKEDIR='@flake@'
HOSTNAME='@host@'
MAIN='@main@'
MKFSEXT4='@mkfsext4@'
MKFSFAT='@mkfsfat@'
NIXOSINSTALL='@nixosinstall@'
PARTED='@parted@'
SWAP='@swap@'

### HELPER FUNCTIONS ###

print_usage() {
	# Print script usage

	cat <<EOF
Usage: $0 [-k KEYFILE]
Install NixOS on a host.

    -k, --key               path to the age key file (if not specified, taken from \$SOPS_AGE_KEY_FILE)
EOF
}

### PARSE ARGUMENTS ###

keyfile="${SOPS_AGE_KEY_FILE:-${XDG_CONFIG_HOME:-${HOME}/.config}/sops/age/keys.txt}}"
unparsed=''

while [ -n "${1:-}" ]; do
	case "$1" in
	-k | --key)
		shift
		keyfile="$1"
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

### CLEANUP ###

printf '%s\n' 'Cleaning up old state'

# remove old age key if exists
rm --force "/mnt/var/lib/sops/age/keys.txt"

# unmount everything
mountpoint --quiet /mnt/ && umount --recursive /mnt/

# disable swap
swapoff "/dev/disk/by-partlabel/${SWAP}" 2>/dev/null || true

### PARTITIONING ###

printf '%s\n' "Partitioning disk ${DISK_A}"

# partition the disk
# use GPT to store partition metadata
# boot partition at the beginning
# and the rest is for the main partition
if ! ${PARTED} --script --align optimal "${DISK_A}" -- \
	mklabel gpt \
	mkpart "${BOOT}" fat32 1MB 512MB \
	set 1 boot on \
	set 1 esp on \
	mkpart "${MAIN}" 512MB 100%; then
	printf '%s\n' "Partitioning disk ${DISK_A} failed" >&2
	exit 1
fi

# partition the disk
# use GPT to store partition metadata
# only swap partition
if ! ${PARTED} --script --align optimal "${DISK_B}" -- \
	mklabel gpt \
	mkpart "${SWAP}" 1MB 100%; then
	printf '%s\n' "Partitioning disk ${DISK_B} failed" >&2
	exit 2
fi

# force udev to reread partition table
udevadm trigger

printf '%s' 'Waiting for partitions to appear...'
while [ ! -e "/dev/disk/by-partlabel/${BOOT}" ] ||
	[ ! -e "/dev/disk/by-partlabel/${MAIN}" ] ||
	[ ! -e "/dev/disk/by-partlabel/${SWAP}" ]; do
	sleep 1
	printf '%s' '.'
done
printf '\n'

printf '%s\n' 'Partitioning complete'

### FORMATTING ###

# format the partitions with appropriate filesystems
# note that referring to devices by by-partlabel works only when using GPT

printf '%s\n' "Formatting /dev/disk/by-partlabel/${BOOT} with FAT32"

# fat32 for the boot partition
if ! ${MKFSFAT} -c -F 32 -n "${BOOT}" "/dev/disk/by-partlabel/${BOOT}"; then
	printf '%s\n' "Formatting /dev/disk/by-partlabel/${BOOT} failed" >&2
	exit 3
fi

printf '%s\n' "Formatting /dev/disk/by-partlabel/${MAIN} with ext4"

# ext4 for the main partition
if ! ${MKFSEXT4} -L "${MAIN}" "/dev/disk/by-partlabel/${MAIN}"; then
	printf '%s\n' "Formatting /dev/disk/by-partlabel/${MAIN} failed" >&2
	exit 4
fi

printf '%s\n' "Formatting /dev/disk/by-partlabel/${SWAP} as swap"

# swap is just swap
if ! mkswap -L "${SWAP}" "/dev/disk/by-partlabel/${SWAP}"; then
	printf '%s\n' "Formatting /dev/disk/by-partlabel/${SWAP} failed" >&2
	exit 5
fi

# force udev to reread filesystems
udevadm trigger

printf '%s' 'Waiting for filesystems to appear...'
while [ ! -e "/dev/disk/by-label/${BOOT}" ] ||
	[ ! -e "/dev/disk/by-label/${MAIN}" ] ||
	[ ! -e "/dev/disk/by-label/${SWAP}" ]; do
	sleep 1
	printf '%s' '.'
done
printf '\n'

printf '%s\n' 'Formatting complete'

### PREPARATION ###

printf '%s\n' 'Enabling swap'

# enable swap already so installation can use more memory
if ! swapon "/dev/disk/by-partlabel/${SWAP}"; then
	printf '%s\n' 'Enabling swap failed' >&2
	exit 6
fi

printf '%s\n' 'Mounting filesystems'

# mount everything
if ! mount --types ext4 "/dev/disk/by-label/${MAIN}" /mnt/ ||
	! mkdir --parents /mnt/boot/ ||
	! mount --types vfat "/dev/disk/by-label/${BOOT}" /mnt/boot/; then
	printf '%s\n' 'Mounting filesystems failed' >&2
	exit 7
fi

printf '%s\n' 'Copying age keys'

# copy age keys
if ! mkdir --parents "/mnt/var/lib/sops/age" ||
	! cp "${keyfile}" "/mnt/var/lib/sops/age/keys.txt"; then
	printf '%s\n' 'Copying age keys failed' >&2
	exit 8
fi

### INSTALLATION ###

printf '%s\n' 'Installing NixOS'

# install
${NIXOSINSTALL} --no-root-passwd --flake "${FLAKEDIR}#${HOSTNAME}" "$@"
