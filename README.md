# MySQL Daisy Chain Replication
In this repo using docker containers, we create a daisy chain replication from mysql 5.1 to 5.7 to 8.0

## Pre-Requisites
If you have a unix based OS and docker installed, you are good to go. With some effort the main script `run.sh` can be converted to `run.bat`. Contributions are appreciated.

## Quick Start
Start `./run.sh`. Docker containers will be created and replication will be stablished. Ending or terminating the script would stop and delete the containers and also the volumes. The reason behind the deletion is that we prefer to test the replication on a clean slate.

## Sample Run
```
$ ./run.sh
Docker version 19.03.5, build 633a0ea
get the default directory
trap teardown function for INT and ERR
stop the containers if running
No stopped containers
clean up mysql data
starting the containers
Building executor
Step 1/3 : FROM centos:centos7
 ---> 5e35e350aded
Step 2/3 : RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm 	&& rm -rf /var/cache/yum/* 	&& yum clean all
 ---> Using cache
 ---> beb2add4eb84
Step 3/3 : RUN yum -y install mysql pv 	&& rm -rf /var/cache/yum/* 	&& yum clean all
 ---> Using cache
 ---> a11e1fbc5e97
Successfully built a11e1fbc5e97
Successfully tagged mysql-daisy-chain-replication_executor:latest
Creating mysql51 ... done
Creating mysql57 ... done
Creating mysql80 ... done
Creating executor ... done
run the scenario in the executor container
testing the connection with: mysql --host mysql51 --port 3306 --user root -e "show databases"
waiting for mysql51...
waiting for mysql51...
mysql51 connected
testing the connection with: mysql --host mysql57 --port 3306 --user root -e "show databases"
waiting for mysql57...
waiting for mysql57...
waiting for mysql57...
waiting for mysql57...
waiting for mysql57...
waiting for mysql57...
waiting for mysql57...
waiting for mysql57...
mysql57 connected
testing the connection with: mysql --host mysql80 --port 3306 --user root -e "show databases"
mysql80 connected
Creating database and tables
Insert some data in master
create master replication user
create master intermediate slave user
restore master on slaves
CHANGE MASTER TO MASTER_PORT=3306, MASTER_HOST='mysql51', MASTER_LOG_FILE='mysql51-log-bin.000003', MASTER_LOG_POS=2417812;
2.25MiB 0:00:01 [1.28MiB/s] [    <=>                                                                                                 ]
2.25MiB 0:00:02 [ 873kiB/s] [      <=>                                                                                               ]
get intermediate slave info
set slave configuration
change slave master to mysql57-log-bin.000003 2342393
start intermediate slave
get intermediate slave info
set intermediate slave configuration
change intermediate slave master to mysql51-log-bin.000003 2417812
Press enter to verify
running on master: INSERT INTO db1.tb2 (value) VALUES ('XYZ123');
sleeping 1 second
running on intermediate slave: SELECT * FROM db1.tb2 WHERE value = 'XYZ123';
id	value
3002	XYZ123
running on slave: SELECT * FROM db1.tb2 WHERE value = 'XYZ123';
id	value
3002	XYZ123
Press enter to end
Stopping executor ... done
Stopping mysql80  ... done
Stopping mysql57  ... done
Stopping mysql51  ... done
Going to remove executor, mysql80, mysql57, mysql51
Removing executor ... done
Removing mysql80  ... done
Removing mysql57  ... done
Removing mysql51  ... done
$
```
