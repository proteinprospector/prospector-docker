# Prospector computational node
FROM c7-systemd
MAINTAINER Pascal Wassam
ENV TERM xterm

RUN yum install -y openssh-clients strace telnet samba
RUN yum clean all
RUN groupadd -g 10000 ppsvr
RUN adduser -u 10000 -g ppsvr ppsvr -m 

RUN systemctl enable smb
ADD smb.conf /etc/samba/smb.conf

CMD ["/usr/sbin/init"]
