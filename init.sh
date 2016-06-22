#!/bin/bash

# Do this so we can read these vars in cron
env > /backup/.env

whenever -f /backup/schedule.rb --clear-crontab
whenever -f /backup/schedule.rb --write-crontab

exec cron -f
