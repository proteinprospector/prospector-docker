#!/bin/bash

# get the path to the script directory
CONFIGDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIG=${CONFIGDIR}/config.sh
echo Using configuration: ${CONFIG}
. ${CONFIG}

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

if [ ${PRIVINTERFACE} != "None" ]; then
	# create samba server, reset associated iptables rules
	iptables -D DOCKER -i ens192 -p tcp -m tcp --dport 445 -j DROP
	iptables -I DOCKER -i ens192 -p tcp -m tcp --dport 445 -j DROP
	echo -n "pp_smb: "
	docker run --name pp_smb --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
	--volumes-from pp_data_storage \
	-p 445:445 -d prospector-samba
fi

# build databases
docker exec -ti pp_node curl ftp://ftp.ncbi.nih.gov/blast/db/FASTA/swissprot.gz -o /prospector_seqdb/SwissProt.2015.01.01.fasta.gz
docker exec -ti pp_node gunzip /prospector_seqdb/SwissProt.2015.01.01.fasta.gz
docker exec -ti pp_node /var/lib/prospector/web/cgi-bin/faindex.cgi - create_database_indicies=1 database=SwissProt.2015.01.01
docker exec -ti pp_node /var/lib/prospector/web/cgi-bin/faindex.cgi - random_database=1 database=SwissProt.2015.01.01

