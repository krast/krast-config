#!/bin/bash

export OCSERV_VERSION=0.11.5

yum install -y gnutls gnutls-utils libev perl-libintl libnl3 libseccomp pam lz4 readline \
               gcc gcc-c++ gnutls-devel libev-devel libnl3-devel libseccomp-devel \
               kernel-headers pam-devel readline-devel tar xz

curl -SL "ftp://ftp.infradead.org/pub/ocserv/ocserv-$OCSERV_VERSION.tar.xz" -o ocserv.tar.xz
curl -SL "ftp://ftp.infradead.org/pub/ocserv/ocserv-$OCSERV_VERSION.tar.xz.sig" -o ocserv.tar.xz.sig
gpg --keyserver pgp.mit.edu --recv-key 7F343FA7
gpg --keyserver pgp.mit.edu --recv-key 96865171
gpg --verify ocserv.tar.xz.sig
mkdir -p /usr/src/ocserv
tar -xf ocserv.tar.xz -C /usr/src/ocserv --strip-components=1
cd /usr/src/ocserv
./configure
make
make install
mkdir -p /etc/ocserv
mkdir -p /etc/ocserv/config-per-group


# Open ipv4 ip forward
sysctl -w net.ipv4.ip_forward=1

# Enable NAT forwarding
iptables -t nat -A POSTROUTING -j MASQUERADE
iptables -A FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu


iptables -A FORWARD -s 192.168.99.0/24 -j ACCEPT

iptables -t nat -A POSTROUTING -s 192.168.99.0/24 -o eth0 -j MASQUERADE

iptables -A FORWARD -p tcp -m tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu

iptables -A FORWARD -o vpns0 -j ACCEPT

iptables -A FORWARD -i vpns0 -j ACCEPT

# Enable TUN device
mkdir -p /dev/net
mknod /dev/net/tun c 10 200
chmod 600 /dev/net/tun

ln -s /usr/lib/systemd/system/ocserv.service /etc/systemd/system/multi-user.target.wants/

ocpasswd -c /etc/ocserv/ocpasswd -g "All,Route" cmdiris
