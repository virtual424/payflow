#!/usr/bin/env bash
# Creates the standard package folders in every service. Safe to re-run (mkdir -p).
set -e

COMMON="config controller dto/request dto/response entity repository service mapper exception"

create() {            # $1 = module folder, $2 = package name, $3 = extra packages
  local base="$1/src/main/java/com/payflow/$2"
  for pkg in $COMMON $3; do
    mkdir -p "$base/$pkg"
  done
  mkdir -p "$1/src/main/resources/db/migration" "$1/src/test/java/com/payflow/$2"
  echo "created $1"
}

create auth         auth         "security"
create wallet       wallet       "security"
create order        order        "inventory client messaging scheduler"
create payment      payment      "client saga processor state messaging scheduler repository/spec"
create notification notification "messaging channel"

# common library (no controllers or DB of its own)
mkdir -p common/src/main/java/com/payflow/common/{exception,web,security,event,util,autoconfigure}
mkdir -p common/src/main/resources/META-INF/spring
echo "created common"