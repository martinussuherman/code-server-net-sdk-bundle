#!/bin/sh

CROND_PARAMS=$@
if [ -z $CROND_CRONTAB ]; then
    echo "missing environment variable: CROND_CRONTAB"
    exit 1
fi

# create user group and home
/create_user_group_home.sh

# chown other paths
/chown_paths.sh

# configure and exec cron deamon
crontab -u $EUSER $CROND_CRONTAB

crond $CROND_PARAMS
