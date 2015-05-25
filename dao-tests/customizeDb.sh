#!/bin/bash

if [[ $# != 1 ]] ; then
    echo 'Usage: cleanDb.sh <database-and-user-name>';
    exit 1;
fi

DB_AND_USER_NAME=$1

echo Customizing database ${DB_AND_USER_NAME} 
psql -U postgres -d ${DB_AND_USER_NAME} -c "UPDATE vdc_options set option_value = 'false' where option_name = 'SSLEnabled';" &&
psql -U postgres -d ${DB_AND_USER_NAME} -c "UPDATE vdc_options set option_value = 'false' where option_name = 'UseSecureConnectionWithServers';" &&
psql -U postgres -d ${DB_AND_USER_NAME} -c "UPDATE vdc_options set option_value = 'false' where option_name = 'EncryptHostCommunication';" &&
psql -U postgres -d ${DB_AND_USER_NAME} -c "UPDATE vdc_options set option_value = 'false' where option_name = 'InstallVds';" &&
echo database ${DB_AND_USER_NAME} successfully updated

