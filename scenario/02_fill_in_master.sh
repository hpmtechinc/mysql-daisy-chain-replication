#!/usr/bin/env bash

echo "Creating database and tables"

mysql --host mysql51 --user root << eof
DROP DATABASE IF EXISTS db1;
CREATE DATABASE db1;
USE db1;

CREATE TABLE tb1 (
  id int(11) NOT NULL AUTO_INCREMENT,
  value varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE tb2 (
  id int(11) NOT NULL AUTO_INCREMENT,
  value varchar(10000) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB;

DROP DATABASE IF EXISTS db2;
CREATE DATABASE db2;
USE db2;

CREATE TABLE tb1 (
  id int(11) NOT NULL AUTO_INCREMENT,
  value varchar(10000) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB;
eof

echo "Insert some data in master"
values="('dummy')";
md5=$(date | md5sum)
for i in {1..3000}
do
    values="${values}, ('${md5} ${md5} ${md5} ${md5} ${md5} ${md5} ${md5} ')"
done

echo "INSERT INTO db1.tb1 (value) VALUES $values;" | mysql --host mysql51 --user root
echo "INSERT INTO db1.tb2 (value) VALUES $values;" | mysql --host mysql51 --user root
echo "INSERT INTO db2.tb1 (value) VALUES $values;" | mysql --host mysql51 --user root

