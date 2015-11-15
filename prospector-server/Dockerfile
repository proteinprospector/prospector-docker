# Prospector headnode. Runs apache, in a machine container.

FROM c7-systemd
MAINTAINER Pascal Wassam

RUN yum install -y epel-release
RUN yum install -y mariadb openmpi openssh-clients strace httpd p7zip unrar ghostscript R-base perl-XML-Simple telnet rsyslog perl-CPAN
RUN (echo y;echo o conf prerequisites_policy follow;echo o conf commit)|cpan ; exit 0
RUN echo y | cpan install Mail::Sendmail
RUN yum clean all 
RUN groupadd -g 10000 ppsvr
RUN adduser -u 10000 -g ppsvr ppsvr -m 
RUN systemctl enable httpd.service


# Host must be set at runtime
ENV PP_DB_HOST None  
ENV PP_DB_PASS pp
ENV PP_DB_USER pp
ENV PP_DB_NAME ppsd

# IP address of quantification server to forward to, or None
ENV PP_QUANT_SERVER 172.16.0.2

# install prospector
ADD prospector.tar.gz /tmp
RUN mv /tmp/prospector/* /var/www/
RUN rmdir /tmp/prospector
RUN ln -s /var/www/etc/prospector.conf /etc/httpd/conf.d/prospector.conf

CMD ["/usr/sbin/init"]
ADD docker-entrypoint.sh / 
ENTRYPOINT ["/docker-entrypoint.sh"]

