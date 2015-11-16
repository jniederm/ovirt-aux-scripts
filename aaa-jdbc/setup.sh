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
DB_USER=${DB_USER:-engine}
DB_PASSWORD=${DB_PASSWORD:-engine}

TARGET_AUTHN=$TARGET/etc/ovirt-engine/extensions.d/${PROFILE_NAME}-authn.properties
TARGET_AUTHZ=$TARGET/etc/ovirt-engine/extensions.d/${PROFILE_NAME}-authz.properties
TARGET_PROFILE=$TARGET/etc/ovirt-engine/aaa/${PROFILE_NAME}.properties

cp $TARGET/share/ovirt-engine-extension-aaa-jdbc/examples/extension.d/authn.properties \
   $TARGET_AUTHN &&

sed -i s/@PROFILE@/${PROFILE_NAME}/g $TARGET_AUTHN &&

cp $TARGET/share/ovirt-engine-extension-aaa-jdbc/examples/extension.d/authz.properties \
   $TARGET_AUTHZ  &&

sed -i s/@PROFILE@/${PROFILE_NAME}/g $TARGET_AUTHZ &&

mkdir -p $TARGET/etc/ovirt-engine/aaa &&
cp $TARGET/share/ovirt-engine-extension-aaa-jdbc/examples/aaa/profile.properties \
   $TARGET_PROFILE &&

sed -i s/@DB_HOST@/${DB_HOST}/g $TARGET_PROFILE &&
sed -i s/@DB_PORT@/${DB_PORT}/g $TARGET_PROFILE &&
sed -i s/@DB_NAME@/${DB_NAME}/g $TARGET_PROFILE &&
sed -i s/@DB_USER@/${DB_USER}/g $TARGET_PROFILE &&
sed -i s/@DB_PASSWORD@/${DB_PASSWORD}/g $TARGET_PROFILE &&

echo "Files successfully created:
$TARGET_AUTHN
$TARGET_AUTHZ
$TARGET_PROFILE
"
