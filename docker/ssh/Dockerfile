FROM centos:6.8
MAINTAINER krast <krast@live.cn>

COPY run.sh  /run.sh
RUN chmod 755 /run.sh
RUN mkdir /root/.ssh/
RUN chmod 700 /root/.ssh/
COPY id_rsa  /root/.ssh/
RUN chmod 644 /root/.ssh/id_rsa
COPY known_hosts  /root/.ssh/
RUN chmod 644 /root/.ssh/known_hosts
RUN rm -rf /etc/yum.reops.d/
COPY centos_6_8_tuna.repo /etc/yum.repos.d/
RUN yum clean all
RUN yum repolist
RUN yum -y install openssh-*

EXPOSE 11111/tcp
ENTRYPOINT ["/run.sh"]
