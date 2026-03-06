#!/usr/bin/env bash
# shellcheck enable=all

__here_path="/$(lsof -p $$ | tail -n1 | cut -d '/' -f2-)"
__here_dir=$(dirname "${__here_path}")

# shellcheck disable=SC1090
. "${__here_dir}/../source/zx.lib.posix.sh"

( 
  set -o posix
  set
) > /tmp/before.txt
_cx "${@}"
( 
  set -o posix
  set
) > /tmp/after.txt

diff /tmp/before.txt  /tmp/after.txt
rm /tmp/before.txt
rm /tmp/after.txt

unset __here_path __here_dir _cx_source
