#!/bin/sh

set -e

sleep 60

if [ "$(find /var/log/curl.log -mmin -5 | wc -l)" -gt 0 ]; then
  exit 0  
else
  exit 1  
fi
