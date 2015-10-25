#!/bin/bash

# create storage volumes
echo -n "pp_db_storage: "
docker create --name pp_db_storage prospector-db-storage

echo -n "pp_seqdb_storage: "
docker create --name pp_seqdb_storage prospector-seqdb-storage

echo -n "pp_data_storage: "
docker create --name pp_data_storage prospector-data-storage

echo -n "pp_param_storage: "
docker create --name pp_params_storage prospector-params-storage

# create database, expose to localhost at least 
echo -n "pp_db: "
docker run --name pp_db --volumes-from pp_db_storage -p 3306:3306 -d prospector-db

