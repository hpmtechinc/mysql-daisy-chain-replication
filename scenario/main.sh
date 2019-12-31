#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

$DIR/01_wait_for_mysql_containers.sh
$DIR/02_fill_in_master.sh
$DIR/03_create_replication_users.sh
$DIR/04_backup_and_restore.sh
$DIR/05_start_slave_replication.sh
$DIR/06_start_intermediate_slave_replication.sh
$DIR/07_verification.sh
