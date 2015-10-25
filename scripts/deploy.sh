#!/bin/bash

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

# build databases
docker exec -ti pp_node curl ftp://ftp.ncbi.nih.gov/blast/db/FASTA/swissprot.gz -o /prospector_seqdb/SwissProt.2015.01.01.fasta.gz
docker exec -ti pp_node gunzip /prospector_seqdb/SwissProt.2015.01.01.fasta.gz
docker exec -ti pp_node /var/lib/prospector/web/cgi-bin/faindex.cgi - create_database_indicies=1 database=SwissProt.2015.01.01
docker exec -ti pp_node /var/lib/prospector/web/cgi-bin/faindex.cgi - random_database=1 database=SwissProt.2015.01.01
