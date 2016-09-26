#!/bin/bash
yum update -y
systemctl stop firewalld
systemctl disable firewalld
iptables -F

mkdir /swapfile
cd /swapfile
dd if=/dev/zero of=swap bs=1024 count=4000000
mkswap -f swap
swapon swap
echo "/swapfile/swap swap swap defaults 0 0" >> /etc/fstab
wget -N --no-check-certificate https://raw.githubusercontent.com/91yun/serverspeeder/master/serverspeeder-all.sh && bash serverspeeder-all.sh

reboot
