#!/bin/bash 

set -e

# create copies of prospector base deployment
cp -f prospector-5.15.0.tar.gz prospector-server/prospector.tar.gz
cp -f prospector-5.15.0.tar.gz prospector-node/prospector.tar.gz

( cd centos-systemd; echo "--- Building centos-systemd"; docker build --rm -t c7-systemd .; )

for img in prospector-params-storage prospector-data-storage prospector-db prospector-db-storage  prospector-node  prospector-seqdb-storage  prospector-server prospector-samba; do
	( cd $img ; echo "--- Building $img";  docker build -t $img . )
done
