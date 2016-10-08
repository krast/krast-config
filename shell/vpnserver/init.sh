#!/bin/bash
yum clean all
yum repolist
yum update -y
#systemctl stop firewalld
#systemctl disable firewalld
#iptables -F

mkdir /swapfile
cd /swapfile
dd if=/dev/zero of=swap bs=1024 count=4000000
mkswap -f swap
swapon swap
echo "/swapfile/swap swap swap defaults 0 0" >> /etc/fstab

cat <<EOF >> /etc/sysctl.conf
net.ipv4.ip_forward = 1
net.ipv4.conf.all.rp_filter = 0
net.ipv4.conf.default.rp_filter = 0
net.ipv4.conf.eth0.rp_filter = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
EOF

reboot

yum install -y ethtool
wget -N --no-check-certificate https://raw.githubusercontent.com/91yun/serverspeeder/master/serverspeeder-all.sh && bash serverspeeder-all.sh

reboot

mkdir -p /root/certs/ocserv
mkdir -p /root/certs/nghttpx
