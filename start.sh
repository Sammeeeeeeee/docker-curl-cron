#!/bin/sh

set -e

export OPTIONS=$OPTIONS

echo "$CRON_SCHEDULE /curl.sh" >> /var/spool/cron/crontabs/root

NEXT_CRON=$(crontab -l | grep -v '^#' | grep -m 1 -oE '[0-9]+ [0-9]+ [0-9]+ [0-9]+ [0-9]+' | awk '{$5+=1;print}' | tr ' ' '\t')

NEXT_CRON_DATE=$(date -d"$NEXT_CRON" "+%M %H %d %m")
HEALTH_CHECK_TIME=$(date -d "$NEXT_CRON_DATE +1 min" "+%M %H %d %m *")

echo "$HEALTH_CHECK_TIME /healthcheck.sh" | crontab -

crond -l 2 -f
