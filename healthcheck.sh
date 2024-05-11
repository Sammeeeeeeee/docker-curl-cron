#!/bin/sh

set -e

# Counter to keep track of the number of consecutive failures
FAILURE_COUNT_FILE="/var/run/healthcheck_failure_count"
FAILURE_THRESHOLD=2

# Check if failure count file exists, if not, create it
if [ ! -f "$FAILURE_COUNT_FILE" ]; then
  echo "0" > "$FAILURE_COUNT_FILE"
fi

# Read failure count
FAILURE_COUNT=$(cat "$FAILURE_COUNT_FILE")

# Check for specific failure message in cron log
if grep -q "CRON JOB FAILURE" /var/log/cron.log; then
  echo "CRITICAL: Cron job failure detected. Service marked as unhealthy." >&2
  exit 1  # Failure
fi

# Wait for a brief interval
sleep 60

# Health check: Look for recent activity in curl log
if [ "$(find /var/log/curl.log -mmin -5 | wc -l)" -gt 0 ]; then
  echo "INFO: Service is healthy." >&2
  # Reset failure count if service is healthy
  echo "0" > "$FAILURE_COUNT_FILE"
  exit 0  
else
  # Increment failure count and check if it exceeds the threshold
  FAILURE_COUNT=$((FAILURE_COUNT + 1))
  echo "$FAILURE_COUNT" > "$FAILURE_COUNT_FILE"
  
  if [ "$FAILURE_COUNT" -lt "$FAILURE_THRESHOLD" ]; then
    echo "WARNING: No recent activity detected in curl log. Service might be unhealthy." >&2
  else
    echo "CRITICAL: No recent activity detected in curl log. Service is unhealthy." >&2
  fi
  exit 1  
fi
