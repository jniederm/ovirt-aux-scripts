#!/bin/sh

DIR=$(dirname ${BASH_SOURCE[0]});

$DIR/../db/cleanDb.sh engine_dao_tests engine &&
PGPASSWORD=a ./packaging/dbscripts/schema.sh -c apply -d engine_dao_tests -u engine &&
make maven BUILD_GWT=0 BUILD_UT=1 EXTRA_BUILD_FLAGS="-P enable-dao-tests -D engine.db.username=engine -D engine.db.password=a -D engine.db.url=jdbc:postgresql://localhost/engine_dao_tests -pl backend/manager/modules/dal" &&
notify-send "DAO tests completed"
