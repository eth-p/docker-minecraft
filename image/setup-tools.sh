#!/usr/bin/env sh
# Note: Bash is not installed yet.
# ------------------------------------------------------------------------------

# Add edge/community repository.
echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

# Update repository cache.
apk upgrade --update

# Install tools.
apk add --update bash curl git ca-certificates
