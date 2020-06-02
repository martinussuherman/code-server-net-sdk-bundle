#!/bin/sh

ENTRYPOINT_COMMAND=$1
shift
ENTRYPOINT_PARAMS=$@

# create user group and home
/create_user_group_home.sh

# chown other paths
/chown_paths.sh

# exec ENTRYPOINT_COMMAND
exec $ENTRYPOINT_COMMAND $ENTRYPOINT_PARAMS
