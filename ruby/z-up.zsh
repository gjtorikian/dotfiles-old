#!/bin/sh
#
# Start Zeus up properly.
#
# USAGE:
#
#   $ z-up

function z-up() {
  if test -e ".zeus.sock";then
    rm .zeus.sock
  fi

  bin/zeus start
}
