#!/bin/sh
#
# Migrate the local Rails database, prepare the test database,
# and forget about the changes to db/schema.rb
#
# USAGE:
#
#   $ db-up

function db-up() {
  ./bin/rake db:migrate db:test:prepare
  if test -e "db/schema.rb";then
    git checkout db/*.rb
  fi

  if test -e "db/structure.sql";then
    git checkout db/*.sql
  fi
}
