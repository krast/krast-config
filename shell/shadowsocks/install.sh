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

# start
# ----------
#container
@echo off
echo.
echo Starting Shadowsocks ... >&2
echo.

echo.
echo Starting Shadowsocks Server ... >&2
echo.
start "Starting Shadowsocks Server ..."
shadowsocks-server.exe -p 8888 -k passwd -m aes-256-cfb -c C:\Users\mkuser\Desktop\shadowsocks-server-win64-1.1.5\config.json -t 600

echo.
echo Starting Shadowsocks Local ... >&2
echo.
start "Starting Shadowsocks Local ..." C:\Users\mkuser\Desktop\shadowsocks-local-win64-1.1.5\shadowsocks-local.exe -s 127.0.0.1 -p 8888 -k passwd -m aes-256-cfb -c C:\Users\mkuser\Desktop\shadowsocks-local-win64-1.1.5\config.json -t 600 -b 0.0.0.0 -l 25
