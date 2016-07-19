#!/bin/bash

# Do this so we can read these vars in cron
printenv | sed 's/^\(.*\)$/export \1/g' > /backup/.env

whenever -f /backup/schedule.rb --clear-crontab
whenever -f /backup/schedule.rb --write-crontab

exec cron -f
