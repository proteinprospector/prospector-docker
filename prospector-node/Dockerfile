# Prospector computational node

FROM centos
MAINTAINER Pascal Wassam

# node parameters
# PP_CPUS is the number of cpus used for MPI jobs. This can be adjusted at container start time, but not during run time
ENV PP_CPUS 4
ENV PP_DB_HOST None
ENV PP_DB_USER pp
ENV PP_DB_PASS pp
ENV PP_DB_NAME ppsd
ENV TERM xterm

RUN yum install -y mariadb-libs openmpi openssh-clients strace telnet wget
RUN yum clean all
RUN groupadd -g 10000 ppsvr
RUN adduser -u 10000 -g ppsvr ppsvr -m 

# Mail::Sendmail install
#RUN yum install -y perl-CPAN
#RUN (echo y;echo o conf prerequisites_policy follow;echo o conf commit)|cpan ; exit 0 
#RUN echo y | cpan install Mail::Sendmail

# wrapper to ensure proper setup
ADD docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
ADD btag_start.sh /

USER ppsvr
ADD prospector.tar.gz /var/lib

WORKDIR /var/lib/prospector/web
