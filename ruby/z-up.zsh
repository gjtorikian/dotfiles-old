#!/bin/sh
#
# Start Zeus up properly.
#
# USAGE:
#
#   $ z-up

function z-up() {
  export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

  if test -e ".zeus.sock";then
    rm .zeus.sock
  fi
  
  db-up
  bin/zeus start
}
