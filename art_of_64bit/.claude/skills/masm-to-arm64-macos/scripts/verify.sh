#!/usr/bin/env bash
# Verify a translated AArch64 .s file assembles (and optionally links+runs
# against a paired C/C++ host file).
#
# Usage:
#   verify.sh <file.s>              # assemble only
#   verify.sh <file.s> <host.cpp>   # assemble, link, run

set -euo pipefail

asm="${1:?usage: verify.sh <file.s> [host.cpp]}"
host="${2:-}"

work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT

obj="$work/$(basename "${asm%.s}").o"
clang -c "$asm" -o "$obj"
echo "OK: $asm assembles cleanly"

if [[ -n "$host" ]]; then
  bin="$work/a.out"
  clang "$host" "$asm" -o "$bin"
  echo "OK: linked $host + $asm"
  echo "--- running ---"
  "$bin"
  echo "--- exited $? ---"
fi
