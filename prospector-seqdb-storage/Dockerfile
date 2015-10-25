# prospector seqdb data container 
FROM prospector-node
MAINTAINER Pascal Wassam

USER 0

RUN mkdir -p /prospector_seqdb
RUN chown 10000:10000 /prospector_seqdb
RUN date > /prospector_seqdb/docker_created_date.txt

VOLUME /prospector_seqdb

