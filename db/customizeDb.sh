#!/bin/bash

if [[ $# != 1 ]] ; then
    echo 'Usage: customizeDb.sh <database-name>';
    exit 1;
fi

DB_NAME=$1

echo Customizing database ${DB_NAME} 
psql -U postgres -d ${DB_NAME} -c "UPDATE vdc_options set option_value = 'false' where option_name = 'SSLEnabled';" &&
psql -U postgres -d ${DB_NAME} -c "UPDATE vdc_options set option_value = 'false' where option_name = 'UseSecureConnectionWithServers';" &&
psql -U postgres -d ${DB_NAME} -c "UPDATE vdc_options set option_value = 'false' where option_name = 'EncryptHostCommunication';" &&
psql -U postgres -d ${DB_NAME} -c "UPDATE vdc_options set option_value = 'false' where option_name = 'InstallVds';" &&
echo database ${DB_NAME} successfully updated

