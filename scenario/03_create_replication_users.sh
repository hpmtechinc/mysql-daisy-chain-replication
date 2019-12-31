#!/usr/bin/env bash

echo "create master replication user"

mysql --host mysql51 --user root << eof
SET SESSION SQL_LOG_BIN=0;
CREATE USER 'rep_user'@'%' IDENTIFIED BY 'secure_password';
GRANT REPLICATION SLAVE ON *.* TO 'rep_user'@'%';
FLUSH PRIVILEGES;
SET SESSION SQL_LOG_BIN=1;
eof

echo "create master intermediate slave user"

mysql --host mysql57 --user root << eof
SET SESSION SQL_LOG_BIN=0;
CREATE USER 'rep_user'@'%' IDENTIFIED BY 'secure_password';
GRANT REPLICATION SLAVE ON *.* TO 'rep_user'@'%';
FLUSH PRIVILEGES;
SET SESSION SQL_LOG_BIN=1;
eof

