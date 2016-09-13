#!/bin/bash

DIR=$(dirname ${BASH_SOURCE[0]});

$DIR/cleanDb.sh engine_dao_tests engine &&
PGPASSWORD=a ./packaging/dbscripts/schema.sh -c apply -d engine_dao_tests -u engine &&
mvn -f ./backend/manager/modules/dal -P enable-dao-tests -Dmaven.surefire.debug test
