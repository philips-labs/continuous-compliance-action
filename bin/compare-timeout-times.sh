#!/bin/bash

[ -n "$1" ] && TIMEOUT_SECONDS=$1 || [ -r "$2" ] && TARGET_REPO_EPOCH_TIME=$2 || exit 1

current_time=$(date +%s)
timeout_time=$(expr "$current_time" - "$TIMEOUT_SECONDS")

# if the target repository time is larger or the same than the time out time, we should not do anything as 
# the repo is within the timeframe and does not need checking.
# In this case we should exit
    if (($TARGET_REPO_EPOCH_TIME >= $timeout_time)); then
        echo 'false'
        exit
    else
# the repo is not within the timeframe and does need checking.
# In this case we should echo something and exit the application.
        echo 'true'
        exit
    fi