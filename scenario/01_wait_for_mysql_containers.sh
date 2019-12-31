#!/usr/bin/env bash

function check_connection() {
    dbc="0"
    # loop until mysql1 is connected
    echo "testing the connection with: mysql --host $1 --port 3306 --user root -e \"show databases\""
    while [ $dbc = "0" ]; do 
        mysql --host $1 --port 3306 --user root -e "show databases" >/dev/null 2>&1 && dbc="1"
        if [ $dbc = "0" ]; then 
            echo "waiting for $1..."
        else
            echo "$1 connected"
        fi
        sleep 2;
    done
}

check_connection mysql51
check_connection mysql57
check_connection mysql80

