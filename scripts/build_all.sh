#!/bin/bash 

set -e

# create copies of prospector base deployment
cp prospector-5.14.3.tar.gz prospector-server/prospector.tar.gz
cp prospector-5.14.3.tar.gz prospector-node/prospector.tar.gz

( cd centos-systemd; echo "--- Building centos-systemd"; docker build --rm -t c7-systemd .; )

for img in prospector-params-storage prospector-data-storage prospector-db prospector-db-storage  prospector-node  prospector-seqdb-storage  prospector-server; do
	( cd $img ; echo "--- Building $img";  docker build -t $img . )
done
