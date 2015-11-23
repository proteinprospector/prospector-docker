#!/bin/bash

# get the path to the script directory
CONFIGDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIG=${CONFIGDIR}/config.sh
echo Using configuration: ${CONFIG}
. ${CONFIG}

# create node, mounting klimt /exports directly
echo -n "pp_node: "
docker run --name pp_node \
--privileged \
-e PP_CPUS=`nproc` \
-v /exports/data3/seqdb:/prospector_seqdb \
-v /exports/data3/params:/prospector_params/params \
-v /exports/data:/prospector_data \
-v /exports/prospector/repository:/prospector_data/repository \
-e PP_DB_PORT_3306_TCP_ADDR=169.230.19.249 \
-d prospector-node /btag_start.sh

