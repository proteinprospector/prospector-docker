#!/bin/bash

# Stop and delete running processes
docker stop pp_db pp_srv pp_node
docker rm pp_db pp_srv pp_node 

