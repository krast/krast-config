FROM centos:6.8
MAINTAINER krast <krast@live.cn>

COPY run.sh  /run.sh
RUN chmod 755 /run.sh
RUN yum install -y squid

EXPOSE 3128/tcp
ENTRYPOINT ["/run.sh"]
