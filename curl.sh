#!/bin/sh

set -e

echo "$(date) - Start"

if curl $OPTIONS; then
    echo "$(date) - OK"
else
    echo "$(date) - FAILED"
    exit 1
fi

echo "$(date) - End"
