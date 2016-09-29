docker pull centos
docker run -dti --privileged \
                --name ocserv \
                -p 85:443/tcp \
                -p 85:443/udp \
                -v /root/certs/server-key.pem:/etc/ocserv/certs/server-key.pem:ro \
                -v /root/certs/server-cert.pem:/etc/ocserv/certs/server-cert.pem:ro \
                centos /bin/bash
docker exec -ti ocserv /bin/bash

mkdir -p /root/certs/
cd /root/certs/

openssl rsa -in server.key -out server-key.pem


docker run --name ocserv \
    --privileged \
    -d \
    --restart=always \
    -p 110:443 \
    -p 110:443/udp \
    -v /root/certs/server-key.pem:/etc/ocserv/certs/server-key.pem:ro \
    -v /root/certs/server-cert.pem:/etc/ocserv/certs/server-cert.pem:ro \
    krast0/ocserv
