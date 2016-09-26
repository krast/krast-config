#!/bin/bash

free -h
mkdir /swapfile
cd /swapfile
dd if=/dev/zero of=swap bs=1024 count=4000000
mkswap -f swap
swapon swap

/etc/fstab
/swapfile/swap swap swap defaults 0 0


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

docker exec -it gitlab update-permissions
docker restart gitlab

docker run --name nginx -d --restart=always \
    --publish 80:80 \
    --publish 443:443 \
    --volume /root/krast-config/blogs/nginx/default.conf:/etc/nginx/conf.d/default.conf:ro \
    --volume /root/krast-config/blogs/pacfile/:/home/nginx/:ro \
    --link wordpress:wordpress \
    --link gitlab:gitlab \
    nginx
