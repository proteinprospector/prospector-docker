#!/bin/bash

# redeploy just the server, node

docker stop pp_srv pp_node
docker rm pp_srv pp_node

set -e

# rebuild the server, node
( cd prospector-server ; docker build -t prospector_server . )
( cd prospector-node ; docker build -t prospector_node . )

# restart the server, node

# create server, expose to localhost
echo -n "pp_srv: "
docker run --name pp_srv --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
--volumes-from pp_seqdb_storage \
--volumes-from pp_data_storage \
--volumes-from pp_params_storage \
-p 80:80 --link pp_db:pp_db -d prospector-server 

# create node 
echo -n "pp_node: "
docker run --name pp_node \
--volumes-from pp_seqdb_storage \
--volumes-from pp_data_storage \
--volumes-from pp_params_storage \
--link pp_db:pp_db -d prospector-node /btag_start.sh

