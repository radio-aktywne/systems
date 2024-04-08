#!/usr/bin/env bash

# Use age keys for SOPS if they exist
if [[ -s /secrets/.agekeys && -r /secrets/.agekeys ]]; then
	confighome="${XDG_CONFIG_HOME:-${HOME}/.config/}"

	# Copy age keys to SOPS config
	targetfile="${confighome}/sops/age/keys.txt"
	mkdir --parents "$(dirname "${targetfile}")"
	cp --force /secrets/.agekeys "${targetfile}"
fi
