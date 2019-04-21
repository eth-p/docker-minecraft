#!/usr/bin/env bash
# ------------------------------------------------------------------------------
set -e
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
# ------------------------------------------------------------------------------

build_status "Cleaning up..."

rm -rf /var/cache/apk/*
rm -rf /build/*
