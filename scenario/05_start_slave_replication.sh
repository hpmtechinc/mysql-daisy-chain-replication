#!/usr/bin/env bash

echo "get intermediate slave info"

IFS=',' read -r -a intermediate_slave_status <<< $(mysql --host mysql57 -ANe "SHOW MASTER STATUS" | tr '\t' ',')
intermediate_slave_log_file="${intermediate_slave_status[0]}"
intermediate_slave_log_position="${intermediate_slave_status[1]}"

echo "set slave configuration"

echo "change slave master to ${intermediate_slave_log_file} ${intermediate_slave_log_position}"

mysql --host mysql80 --user root << eof
SET SESSION SQL_LOG_BIN=0;
STOP SLAVE;
CHANGE MASTER TO 
	MASTER_HOST='mysql57',
	MASTER_PORT=3306,
	MASTER_USER='rep_user',
	MASTER_PASSWORD='secure_password', 
	MASTER_LOG_FILE='$intermediate_slave_log_file', 
	MASTER_LOG_POS=$intermediate_slave_log_position;
START SLAVE;
SET SESSION SQL_LOG_BIN=1;
eof

