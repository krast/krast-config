#!/bin/bash
yum install -y openssl openssl-devel\
               gcc gcc-c++ \
               autoconf automake make \
               libgcc libstdc++ \
               libev libev-devel \
               jemalloc jemalloc-devel \
               libtool git

#
cd ~
git clone https://github.com/nghttp2/nghttp2.git
cd nghttp2 && autoreconf -i \
           && automake \
           && autoconf \
           && ./configure \
           && make \
           && make install-strip

ln -s /usr/lib/systemd/system/nghttp2.service /etc/systemd/system/multi-user.target.wants/
systemctl enable nghttp2

mkdir -p /etc/nghttpx/

# systemd
ln -s /usr/lib/systemd/system/nghttp2.service /etc/systemd/system/multi-user.target.wants/

# firewalld
/usr/lib/firewalld/services/nghttp2.xml

firewall-cmd --zone=public --permanent --list-services
firewall-cmd --zone=public --permanent --add-service=nghttp2
firewall-cmd --zone=public --permanent --delete-service=nghttp2
firewall-cmd --reload
