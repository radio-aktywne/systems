#!/usr/bin/env bash

### CONFIGURATION ###

LOGO='@logo@'
MOTDFILE='@motdfile@'

### FUNCTIONS ###

# Get temporary file
get_temporary_file() {
	mktemp
}

# Print motd
print_motd() {
	lolcat --force <"${LOGO}"
}

# Move file contents
# $1: source
# $2: destination
move_file_contents() {
	cat "${1}" >"${2}"
}

# Remove temporary file
# $1: file
remove_temporary_file() {
	rm --force "${1}"
}

# Execute
execute() {
	file="$(get_temporary_file)"
	print_motd "$@" >"${file}" || return 1
	move_file_contents "${file}" "${MOTDFILE}" || return 2
	remove_temporary_file "${file}" || return 3
}

### MAIN ###

execute "$@"
