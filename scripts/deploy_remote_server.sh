#!/bin/bash

# get the path to the script directory
CONFIGDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIG=${CONFIGDIR}/config.sh
echo Using configuration: ${CONFIG}
. ${CONFIG}

# create server, expose to localhost
echo -n "pp_srv: "
docker run --name pp_srv --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
-v /exports/data3/seqdb:/prospector_seqdb \
-v /exports/data3/params:/prospector_params/params \
-v /exports/data:/prospector_data \
-v /exports/prospector/repository:/prospector_data/repository \
-p 80:80 --link pp_db:pp_db -d prospector-server 

if [ ${PRIVINTERFACE} != "None" ]; then
	# create samba server, reset associated iptables rules
	iptables -D DOCKER -i ens192 -p tcp -m tcp --dport 445 -j DROP
	iptables -I DOCKER -i ens192 -p tcp -m tcp --dport 445 -j DROP
	echo -n "pp_smb: "
	docker run --name pp_smb --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
	-v /exports/data:/prospector_data \
	-v /exports/prospector/repository:/prospector_data/repository \
	-p 445:445 -d prospector-samba
fi
