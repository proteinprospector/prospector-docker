#!/bin/bash

# Stop and delete running processes
docker stop pp_srv pp_node 
docker rm pp_srv pp_node 

