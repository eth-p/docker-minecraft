#!/usr/bin/env bash
# ------------------------------------------------------------------------------
set -e
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
# ------------------------------------------------------------------------------

build_status "Enabling tools at /mc/bin"

for tool in /mc/bin/*; do
	if [[ "$tool" =~ \.sh$ ]]; then
		chmod +x "$tool"
		mv "$tool" "$(dirname "$tool")/$(basename "$tool" ".sh")"
	fi
done

build_status "Cleaning up..."

rm -rf /var/cache/apk/*
rm -rf /build/*
