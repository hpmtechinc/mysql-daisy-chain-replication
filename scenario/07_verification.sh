#!/usr/bin/env bash

read -p "Press enter to verify"

query="INSERT INTO db1.tb2 (value) VALUES ('XYZ123');"
echo "running on master: ${query}"
echo "${query}" | mysql --host mysql51 --user root

echo "sleeping 1 second"
sleep 1

query="SELECT * FROM db1.tb2 WHERE value = 'XYZ123';"
echo "running on intermediate slave: ${query}"
echo "${query}" | mysql --host mysql57 --user root

query="SELECT * FROM db1.tb2 WHERE value = 'XYZ123';"
echo "running on slave: ${query}"
echo "${query}" | mysql --host mysql80 --user root


