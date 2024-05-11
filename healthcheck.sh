#!/bin/sh

set -e

if grep -q "CRON JOB FAILURE" /var/log/cron.log; then
  exit 1  # Failure
fi

sleep 60

if [ "$(find /var/log/curl.log -mmin -5 | wc -l)" -gt 0 ]; then
  exit 0  # Success
else
  exit 1  # Failure
fi
