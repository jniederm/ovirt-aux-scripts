#!/usr/bin/env bash

if [[ $# != 1 ]]; then
    echo 'Usage: setup.sh <target-directory>'
    exit 1
fi

TARGET=$1

PROFILE_NAME=${PROFILE_NAME:-jdbc}
DB_HOST=${DB_HOST:-localhost}
DB_PORT=${DB_PORT:-5432}
DB_NAME=${DB_NAME:-aaa}
DB_SCHEMA=${DB_SCHEMA:-public}
DB_USER=${DB_USER:-engine}
DB_PASSWORD=${DB_PASSWORD:-engine}

$TARGET/share/ovirt-engine-extension-aaa-jdbc/dbscripts/schema.sh \
  -s $DB_HOST \
  -p $DB_PORT \
  -d $DB_NAME \
  -u $DB_USER \
  -e $DB_SCHEMA \
  -c apply &&

echo "Schema of database $DB_NAME.$DB_SCHEMA successfully updated"
