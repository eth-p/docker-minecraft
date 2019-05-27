#!/usr/bin/env bash
# ------------------------------------------------------------------------------
[[ -z "${BASH_SOURCE[1]}" ]] && { echo "This is not executable."; exit 1; }
# ------------------------------------------------------------------------------

build_status() {
	local sep="$(printf "%-80s" "" | tr ' ' '-')"
	printf "\x1B[33m%s\n%s\n%s\x1B[0m\n" "$sep" "$1" "$sep"
}

build_note() {
	case "$1" in
		SLOW)          build_note "This may take a while..."                                  ;;
		SLOW_DOWNLOAD) build_note "This may take a while depending on your download speed..." ;;
		*) printf "\x1B[33m%s\x1B[0m\n" "$1" ;;
	esac
}
