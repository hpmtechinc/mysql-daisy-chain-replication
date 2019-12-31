#!/usr/bin/env bash

echo "restore master on slaves"
mysqldump --host mysql51 --user root \
  --set-charset --extended-insert \
  --compress --master-data=1 --single-transaction \
  --add-locks --databases db1 db2 \
| sed "s/^CHANGE MASTER TO/CHANGE MASTER TO MASTER_PORT=3306, MASTER_HOST='mysql51',/" \
| pv | tee >(mysql --host mysql57 --user root) \
| pv | tee >(mysql --host mysql80 --user root) \
| grep --line-buffered 'CHANGE MASTER TO' \
| tee /tmp/master.log

