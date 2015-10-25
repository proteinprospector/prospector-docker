#!/bin/bash

docker stop pp_db pp_srv pp_node

set -e

MYSQLDATA=`docker inspect -f '{{index .Volumes "/var/lib/mysql"}}' pp_db`
tar -czvf mysql_backup.tar.gz --transform "s,^,mysql-backup/," ${MYSQLDATA}

REPODATA=`docker inspect -f '{{index .Volumes "/prospector_data"}}' pp_data_storage`
tar -czvf repo_backup.tar.gz --transform "s,^,repo-backup/," ${REPODATA}

docker start pp_db
sleep 5
docker start pp_srv
docker start pp_node
