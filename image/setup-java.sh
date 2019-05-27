#!/usr/bin/env bash
# ------------------------------------------------------------------------------
set -e
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
# ------------------------------------------------------------------------------

# Use Alpine OpenJDK 8
build_status "Installing OpenJDK 8..."
build_note SLOW_DOWNLOAD
apk add nss
apk add openjdk8
apk add openjdk8-jre
