# prospector db data container 
FROM c7-systemd
MAINTAINER Pascal Wassam

RUN mkdir -p /var/lib/mysql
RUN date > /var/lib/mysql/docker_created_date.txt
VOLUME /var/lib/mysql
