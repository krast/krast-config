#!/bin/bash

# reqires: docker
# author: krast@live.cn

# init
# ----
docker pull mariadb
docker pull wordpress
docker pull nginx
docker pull sameersbn/squid
docker pull tommylau/ocserv


# mariadb
# -------
docker run --name mysql -d --restart=always -e MYSQL_ROOT_PASSWORD=password mariadb

# wordpress
# ---------
docker run --name wordpress -d --restart=always --link mysql:mysql wordpress

# gitlab
# ------
docker run --detach \
    --privileged \
    --publish 1443:443 --publish 180:80 --publish 22222:22 \
    --name gitlab \
    --hostname git.krast.cn \
    --restart always \
    --volume /srv/gitlab/config:/etc/gitlab \
    --volume /srv/gitlab/logs:/var/log/gitlab \
    --volume /srv/gitlab/data:/var/opt/gitlab \
    gitlab/gitlab-ce:latest

# nginx
# -----
docker run --name nginx -d --restart=always \
  --publish 80:80 \
  --publish 443:443 \
  --volume /root/krast-config/blogs/nginx/default.conf:/etc/nginx/conf.d/default.conf:ro \
  --volume /root/krast-config/blogs/pacfile/:/home/nginx/:ro \
  --link wordpress:wordpress \
  --link gitlab:gitlab \
  nginx

# squid
# -----
docker run --name squid -d --restart=always \
  --publish 21:3128 \
  --volume /root/krast-config/blogs/squid/squid.conf:/etc/squid3/squid.conf:ro \
  --volume /srv/docker/squid/cache:/var/spool/squid3 \
  sameersbn/squid

# ocserv
# ------
docker run --name ocserv \
  --privileged \
  -d \
  --restart=always \
  -p 85:443 \
  -p 85:443/udp \
  -e CA_CN="Krast CA" \
  -e CA_ORG="Krast Corp" \
  -e CA_DAYS=3650 \
  -e SRV_CN=krast.cn \
  -e SRV_ORG="Krast" \
  -e SRV_DAYS=365 -d tommylau/ocserv
