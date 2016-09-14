#!/bin/bash
docker run --name ocserv \
  --privileged -d \
  --restart=always \
  -p 110:443 -p 110:443/udp \
  tommylau/ocserv

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


  docker run --name ocserv \
    --privileged \
    -d \
    --restart=always \
    -p 85:443 \
    -p 85:443/udp \
    -v /root/certs/server-key.pem:/etc/ocserv/certs/server-key.pem:ro \
    -v /root/certs/server-cert.pem:/etc/ocserv/certs/server-cert.pem:ro \
    tommylau/ocserv

  docker run --name ocserv443 \
    --privileged \
    -d \
    --restart=always \
    -p 443:443 \
    -p 443:443/udp \
    -v /root/certs/server-key.pem:/etc/ocserv/certs/server-key.pem:ro \
    -v /root/certs/server-cert.pem:/etc/ocserv/certs/server-cert.pem:ro \
    tommylau/ocserv

docker exec -ti ocserv ocpasswd -c /etc/ocserv/ocpasswd -g "Route,All" cmdiris
docker exec -ti ocserv443 ocpasswd -c /etc/ocserv/ocpasswd -g "Route,All" cmdiris
docker exec -ti ocserv ocpasswd -c /etc/ocserv/ocpasswd -d cmdiris
