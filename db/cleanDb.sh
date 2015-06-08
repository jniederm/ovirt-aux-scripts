#!/bin/bash

if [[ $# != 1 && $# != 2 ]] ; then
    echo 'Usage: cleanDb.sh <database-and-user-name>';
    echo '       cleanDb.sh <database-name> <user-name>';
    exit 1;
fi

if [[ $# == 1 ]] ; then
    DB_NAME=$1
    USER_NAME=$1
fi

if [[ $# == 2 ]] ; then
    DB_NAME=$1
    USER_NAME=$2
fi

echo Cleaning database ${DB_NAME}
psql -U postgres -c "drop database if exists \"${DB_NAME}\";" &&
psql -U postgres -c "create database \"${DB_NAME}\" owner \"${USER_NAME}\" template template0 encoding 'UTF8' lc_collate 'en_US.UTF-8' lc_ctype 'en_US.UTF-8';" &&
echo database ${DB_NAME} owned by ${USER_NAME} successfully recreated

