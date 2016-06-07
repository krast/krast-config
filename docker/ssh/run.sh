#!/bin/bash

echo "Starting SSH Server ..."
ssh -ND 0.0.0.0:11111 root@192.168.0.1
