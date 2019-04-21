#!/usr/bin/env sh
# Note: Bash is not installed yet.
# ------------------------------------------------------------------------------

apk upgrade --update
apk add --update bash tput curl git ca-certificates
