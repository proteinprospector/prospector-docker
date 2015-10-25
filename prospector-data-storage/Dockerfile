# prospector data container 
# this is intended to map whatever central storage exists (nfs, cifs, or local) into prospector-nodes and prospector-server

FROM c7-systemd
MAINTAINER Pascal Wassam

RUN mkdir -p /prospector_data 
RUN mkdir -p /prospector_data/repository /prospector_data/raw /prospector_data/peaklists /prospector_data/repository/temp 
RUN chown -R 10000:10000 /prospector_data
RUN date > /prospector_data/docker_created_date.txt

VOLUME /prospector_data
