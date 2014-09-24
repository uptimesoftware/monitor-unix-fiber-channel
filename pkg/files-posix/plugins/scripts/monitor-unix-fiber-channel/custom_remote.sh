#!/bin/sh
/usr/local/uptime/apache/bin/php rcs.php -h=$UPTIME_HOSTNAME -p=$UPTIME_PORT -s=$UPTIME_PASSWORD -c=fc_monitor -a=$UPTIME_ARGS
