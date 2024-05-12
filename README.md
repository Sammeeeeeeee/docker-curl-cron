# curl-cron

Docker image that runs a runs a curl command based on cron, for healthchecks.io

## Usage
> [!IMPORTANT]  
> All relases after v1.0.0, **even if not marked as pre release**, are unstable and will not work. **This includes the `latest` tag!**

    docker run -d [OPTIONS] sammeeeee/cron-curl:v1.0.0


### Required Parameters:

* `-e OPTIONS=<OPTIONS>`: curl command options, accepts varibles. 
* `-e CRON_SCHEDULE="0 1 * * *"`: specifies when cron job starts ([details](http://en.wikipedia.org/wiki/Cron)), e.g. `0 1 * * *` (runs every night at 1:00).

## Examples:

Run every hour with cron schedule (container keeps running):

    docker run -d \
        -e OPTIONS=example.com \
        -e CRON_SCHEDULE="0 1 * * *" \
        sammeeeee/cron-curl:v1.0.0

