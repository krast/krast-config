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
