# curl-cron

Docker image that runs a runs a curl command based on cron

## Usage

    docker run -d [OPTIONS] sammeeeee/cron-curl:latest


### Required Parameters:

* `-e OPTIONS=<OPTIONS>`: curl command options, accepts varibles. 
* `-e CRON_SCHEDULE="0 1 * * *"`: specifies when cron job starts ([details](http://en.wikipedia.org/wiki/Cron)), e.g. `0 1 * * *` (runs every night at 1:00).

### Optional parameters:

* `now`: run container once and exit (no cron scheduling).

## Examples:

Run every hour with cron schedule (container keeps running):

    docker run -d \
        -e OPTIONS=example.com \
        -e CRON_SCHEDULE="0 1 * * *" \
        sammeeeee/cron-curl:latest

Run just once (container is deleted afterwards):

    docker run --rm \
        -e OPTIONS=example.com \
        sammeeeee/cron-curl:latest now

