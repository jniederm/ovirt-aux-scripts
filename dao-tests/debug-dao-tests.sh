#!/bin/bash

DIR=$(dirname ${BASH_SOURCE[0]});

$DIR/../db/cleanDb.sh engine_dao_tests engine &&
PGPASSWORD=a ./packaging/dbscripts/schema.sh -c apply -d engine_dao_tests -u engine &&
mvn -f ./backend/manager/modules/dal -P enable-dao-tests -D engine.db.username=engine -D engine.db.password=a -D engine.db.url=jdbc:postgresql://localhost/engine_dao_tests -Dmaven.surefire.debug test &&
notify-send "DAO tests completed"
