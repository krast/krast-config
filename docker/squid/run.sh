#!/bin/bash

echo "Starting Squid Server..."
$(which squid) -f /etc/squid/squid.conf -NYCd 1
