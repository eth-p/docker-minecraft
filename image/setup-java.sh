#!/usr/bin/env bash
# ------------------------------------------------------------------------------
set -e
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
# ------------------------------------------------------------------------------

# Use Alpine OpenJDK 11
build_status "Installing OpenJDK ${JAVA_VERSION}..."
build_note SLOW_DOWNLOAD
apk add nss
apk add "openjdk${JAVA_VERSION}"
apk add "openjdk${JAVA_VERSION}-jre"

