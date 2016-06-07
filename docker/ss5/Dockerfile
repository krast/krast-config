FROM centos:6.8
MAINTAINER krast <krast@live.cn>

COPY run.sh  /run.sh
RUN chmod 755 /run.sh
RUN rm -rf /etc/yum.reops.d/
COPY centos_6_8_tuna.repo /etc/yum.repos.d/
RUN yum clean all
RUN yum repolist
RUN yum -y install gcc automake make wget pam-devel openldap-devel cyrus-sasl-devel openssl-devel
RUN wget http://heanet.dl.sourceforge.net/project/ss5/ss5/3.8.9-8/ss5-3.8.9-8.tar.gz
RUN tar zxvf ss5-3.8.9-8.tar.gz
RUN cd ss5-3.8.9 && ./configure && make && make install

EXPOSE 1080/tcp
ENTRYPOINT ["/run.sh"]
