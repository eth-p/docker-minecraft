#!/usr/bin/env sh
# ------------------------------------------------------------------------------
set -e
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
# ------------------------------------------------------------------------------

build_status Installing system tools and libraries...
build_note   SLOW_DOWNLOAD

apk upgrade --update
apk add --update bash curl git ca-certificates

