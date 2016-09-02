#!/bin/bash
docker run -i --rm -p 444:3000 dit4c/nghttpx \
  --frontend-no-tls \
  --host-rewrite \
  -b krast.cn,21



# (Self-signed certs, as above)
# Run nghttpx in background
docker run -d --name spdy \
  -p 444:3000 \
  --link squid:squid \
  dit4c/nghttpx \
  -b squid,3128 \
  --frontend-no-tls \
  --backend-no-tls



docker run -ti --name spdy \
  -p 444:3000 \
  --link squid:squid \
  dit4c/nghttpx \
  /bin/sh

docker rm -f nghttpx
docker run --name nghttpx -d -p 444:3000 -v /data/spdy:/data \
    --link squid:squid \
    -e HOST=krast.cn -e PORT=3128 \
    dajobe/nghttpx

    docker run --name nghttpx -td -p 444:3000 -v /data/spdy:/data \
        --link squid:squid \
        -e HOST=krast.cn -e PORT=3128 \
        dajobe/nghttpx /bin/bash

    docker exec -ti nghttpx /bin/bash

nghttpx -s -D --conf /data/etc/nghttpx.conf  --backend=krast.cn,3128 --frontend=*,3000 --frontend-no-tls


echo test > test_$(date +%Y-%m-%d%H%M%S).txt
