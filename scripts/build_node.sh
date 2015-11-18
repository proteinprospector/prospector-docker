#!/bin/bash 

# build just the node

set -e

# create copies of prospector base deployment
cp prospector-5.14.3.tar.gz prospector-server/prospector.tar.gz
cp prospector-5.14.3.tar.gz prospector-node/prospector.tar.gz

for img in prospector-node; do
	( cd $img ; echo "--- Building $img";  docker build -t $img . )
done
