#########################################
#  Wanda Cloud CentOS 7.2 KickStart uEFI
#########################################

#version=DEVEL
# System authorization information
auth --enableshadow --passalgo=sha512
# Use CDROM installation media
cdrom
# Use graphical install
graphical
# Run the Setup Agent on first boot
firstboot --enable
ignoredisk --only-use=sda
# Keyboard layouts
keyboard --vckeymap=us --xlayouts='us'
# System language
lang en_US.UTF-8

# Network information
network  --device eth0 --vlanid 175 --bootproto static --ip 10.214.175.210 --netmask 255.255.255.0 --gateway 10.214.175.1
network  --bootproto=dhcp --device=eth1 --onboot=off --ipv6=auto
network  --bootproto=dhcp --device=eth2 --onboot=off --ipv6=auto
network  --bootproto=dhcp --device=eth3 --onboot=off --ipv6=auto
network  --hostname=localhost.localdomain

# Root password Wanda12345@Cloud
rootpw --iscrypted $6$Nbi3r6pkz.atR1r6$wZxrnv1UnOvj6nvasguSSVXm0N3eZimB0nKZPCDhPXsCYWgcFVXxIy7qeVl3.yrcDxpuxaNBJHt6.y7CPW.By0
# System services
services --disabled="chronyd,NetworkManager"
firewall --disabled
selinux --disabled
# System timezone
timezone Asia/Shanghai --isUtc --nontp
# System bootloader configuration
bootloader --append=" crashkernel=auto" --location=mbr --boot-drive=sda
# Partition clearing information
clearpart --all --initlabel --drives=sda
# Disk partitioning information
part / --fstype="xfs" --ondisk=sda --size=512 --grow
part swap --fstype="swap" --ondisk=sda --size=32768
part /boot --fstype="xfs" --ondisk=sda --size=500
part /boot/efi --fstype="efi" --ondisk=sda --size=200 --fsoptions="umask=0077,shortname=winnt"

reboot

%packages
@^minimal
@core
kexec-tools
screen
qemu-kvm
libvirt
virt-manager
xorg-x11-xauth
xorg-x11-fonts-*
xorg-x11-utils
bridge-utils

%end

%addon com_redhat_kdump --enable --reserve-mb='auto'

%end

%pre --log=/root/ks-pre.log

%end

%post --nochroot --log=/mnt/sysimage/root/ks-post.log --interpreter=/usr/bin/bash
mkdir /mnt/sysimage/root/.ssh
curl -o /mnt/sysimage/root/.ssh/authorized_keys http://10.214.125.12/keys.cfg
curl -o /mnt/sysimage/root/.ssh/authorized_keys http://10.214.125.12/wanda-centos-7.repo
%end
