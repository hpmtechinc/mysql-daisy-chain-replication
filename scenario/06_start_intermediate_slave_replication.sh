#!/usr/bin/env bash

echo "start intermediate slave"

echo "get intermediate slave info"

IFS=',' read -r -a intermediate_slave_status <<< $(mysql --host mysql57 -ANe "SHOW SLAVE STATUS" | tr '\t' ',')
master_log_file="${intermediate_slave_status[5]}"
master_log_position="${intermediate_slave_status[6]}"

echo "set intermediate slave configuration"

echo "change intermediate slave master to ${master_log_file} ${master_log_position}"

mysql --host mysql57 --user root << eof
SET SESSION SQL_LOG_BIN=0;
STOP SLAVE;
CHANGE MASTER TO 
	MASTER_HOST='mysql51',
	MASTER_PORT=3306,
	MASTER_USER='rep_user', 
	MASTER_PASSWORD='secure_password',
	MASTER_LOG_FILE='$master_log_file', 
	MASTER_LOG_POS=$master_log_position;
START SLAVE;
SET SESSION SQL_LOG_BIN=1;
eof
