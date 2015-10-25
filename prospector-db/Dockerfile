# Prospector database. Will initialize a default schema

FROM mariadb
MAINTAINER Pascal Wassam

# load initial database schema
ADD 1_pp.sql    /docker-entrypoint-initdb.d/
ADD 2_privs.sql /docker-entrypoint-initdb.d/

ENV TERM xterm
ENV MYSQL_DATABASE ppsd 
ENV MYSQL_USER pp
ENV MYSQL_PASSWORD pp
ENV MYSQL_ALLOW_EMPTY_PASSWORD yes

