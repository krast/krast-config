#!/bin/bash
yum install -y squid
systemctl enable squid
systemctl start squid
