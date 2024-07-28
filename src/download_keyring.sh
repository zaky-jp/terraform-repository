#!/bin/bash
set -eu

if [[ $# -ne 1 ]]; then
	echo "Invalid number of arguments given" 1>&2
	exit 1
fi
DEST_PATH=$1
DEST_DIR=$(dirname "${DEST_PATH}")

KEYRING_URL="https://apt.releases.hashicorp.com/gpg"

# create destination dir if not exist
if [[ ! -d ${DEST_DIR} ]]; then
	mkdir -p "${DEST_DIR}"
fi

if [[ ! -e "$DEST_PATH" ]]; then
	#curl -fsSL "${KEYRING_URL}" | gpg --dearmor -o "${DEST_PATH}"
	curl -fsSL "${KEYRING_URL}" -o "${DEST_PATH}"
fi
