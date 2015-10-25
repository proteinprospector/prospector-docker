prospector-docker design notes

prospector-docker is a docker-oriented deployment of UCSF Protein Prospector.
It is intended for easy initial deployment of the Protein Prospector on a single centos 7 system.
With some configuration work, it can be extended to multiple node systems to support more parallel searches.

Docker architecture:

	Data containers:
		All data is presented to the servers, nodes, and database via docker storage containers.
		These are used to simplify both the creation of brand new prospector installs, and linking a prospector-docker instance to existing data stores.

		prospector-data-storage:
			Contains prospector repository and temp directories.
			Also contains input peaklists and raw files.

			Optionally imports a user provided prospector_data directory
			Exports /prospector_data for use by other docker containers

		prospector-db-storage:
			Contains the /var/lib/mysql directory for prospector-db.
			Exports /var/lib/mysql

		prospector-params-storage:
			Contains the parameter files for prospector. 
			These are broken out into their own container for easy replacement of parameters.

			Exports /prospector_params

		prospector-seqdb-storage:
			Contains the sequence databases. 
			These are broken out into their own container for easy update/replacement of parameters.

			Exports /prospector_seqdb

	Application containers:

		prospector-db:
			Mariadb instance to support prospector. When initialized, will create a blank prospector schema if
			the imported /var/lib/mysql is empty.

			REQUIRES: volume import of /var/lib/mysql from prospector-db-storage
			PROVIDES: mysql service

		prospector-server:
			Prospector head node, inside apache. This is what users connect to for job submission.

			REQUIRES: Volume import of /prospector_data, /prospector_seqdb, /prospector_params
					  Link to prospector-db
			PROVIDES: http/80 tcp

		prospector-node:
			Prospector computational node. This is what processes data.

			REQUIRES: Volume import of /prospector_data, /prospector_seqdb, /prospector_params
			          Link to prospector-db










