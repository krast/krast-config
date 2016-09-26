#!/bin/bash
nghttpx -D -n 8 --tls-proto-list TLSv1.2 -s     -f *,23 --no-ocsp -b 127.0.0.1,3128     /root/certs/server-key.pem /root/certs/server-cert.pem
