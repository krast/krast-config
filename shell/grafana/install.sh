#!/bin/bash

#################################################
# Filename:     #filename
# Revision:     #revision
# CreateTime:   #createtime
# Requires:     #requires
# Description:  #description
# -----------
# Author:       krast
# Email:        krast@live.cn
# Github:       https://github.com/krast
#################################################

#firewalld
/usr/lib/firewalld/services/grafana.xml

firewall-cmd --zone=public --permanent --list-services
firewall-cmd --zone=public --permanent --add-service=grafana
firewall-cmd --reload
