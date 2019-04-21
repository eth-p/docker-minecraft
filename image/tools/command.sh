#!/usr/bin/env bash
printf "\x15%s\n" "$*" >/proc/1/fd/1
