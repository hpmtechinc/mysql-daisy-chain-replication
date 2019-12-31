#!/usr/bin/env bash

docker -v

echo "get the default directory"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

dc="docker-compose -f ${DIR}/docker-compose.yml"

function teardown() {
    $dc stop  || true
    $dc rm -f || true
}

echo "trap teardown function for INT and ERR"
trap "teardown;exit 1;" INT ERR

echo "stop the containers if running"
teardown

echo "clean up mysql data"
rm -rf $DIR/data/*

echo starting the containers
$dc up --force-recreate --build --remove-orphans -d
# $dc up -d

echo "run the scenario in the executor container"

docker exec -it executor bash -c "/scenario/main.sh"

read -p "Press enter to end"
teardown

