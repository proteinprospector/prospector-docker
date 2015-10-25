#!/bin/bash
# due to startup delays, crashes, we will reexecute forever

while `true`; do
	/var/lib/prospector/web/cgi-bin/btag-daemon run /var/lib/prospector/web
	sleep 1
done
