# prospector params container 
# This container contains the default params used on server, node creation

FROM c7-systemd
MAINTAINER Pascal Wassam

RUN mkdir -p /prospector_params
RUN chown -R 10000:10000 /prospector_params
ADD params.tar.gz /prospector_params
RUN date > /prospector_params/docker_created_date.txt

VOLUME /prospector_params
