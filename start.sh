#!/bin/sh

set -e

export OPTIONS=$OPTIONS

echo "$CRON_SCHEDULE /curl.sh" >> /var/spool/cron/crontabs/root#

crond -l 2 -f
