#!/bin/bash

if [[ $# != 1 ]] ; then
    echo 'Usage: separateDaoTestDebug.sh <TestClassName>';
    exit 1;
fi

TEST_CLASS_NAME=$1

DIR=$(dirname ${BASH_SOURCE[0]});

$DIR/cleanDb.sh engine_dao_tests engine &&
PGPASSWORD=engine ./packaging/dbscripts/schema.sh -c apply -d engine_dao_tests -u engine &&
mvn -f ./backend/manager/modules/dal -Dtest=${TEST_CLASS_NAME} -Dmaven.surefire.debug test
