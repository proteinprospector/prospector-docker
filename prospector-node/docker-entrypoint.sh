#!/bin/bash
set -e

# make sure our prerequeisite mounts are here
for d in "/prospector_data" "/prospector_seqdb" "/prospector_params/params" ; do
	if [ ! -d $d ]; then
		echo "$d not mounted"
		exit 1
	fi
done

# make sure that required subdirectories exist in /prospector_data
mkdir -p /prospector_data/repository /prospector_data/raw /prospector_data/peaklists /prospector_data/repository/temp
chown 10000:10000 /prospector_data/repository /prospector_data/raw /prospector_data/peaklists /prospector_data/repository/temp

# base path of prospector install
PPBASE="/var/lib/prospector"

# create the the params copy if it does not exist
if [ ! -f $PPBASE/web/params/info.txt ]; then
	mkdir -p $PPBASE/web/params
	cp -vpr /prospector_params/params $PPBASE/web/
fi

# every execution refresh the info.txt configuration
sed -e "s/@@DB_HOST@@/$PP_DB_PORT_3306_TCP_ADDR/" \
    -e "s/@@DB_PASS@@/$PP_DB_PASS/" \
    -e "s/@@DB_USER@@/$PP_DB_USER/" \
    -e "s/@@DB_NAME@@/$PP_DB_NAME/" \
    $PPBASE/web/params/info_template.txt > $PPBASE/web/params/info.txt

sed -e "s/@@PP_CPUS@@/$PP_CPUS/" \
    $PPBASE/web/cgi-bin/mssearchmpi.pl.template > $PPBASE/web/cgi-bin/mssearchmpi.pl
chmod 775 $PPBASE/web/cgi-bin/mssearchmpi.pl	

# proceed with execution
exec "$@"
