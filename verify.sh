#!/usr/local/bin/bash

source $HOME/src/borg/env.sh
OPTIONS="--repair --lock-wait 30 --verbose"

yes YES | /usr/local/bin/borg check $OPTIONS $VAULT || borg_notify "Verify unsuccessful!"

