#!/usr/local/bin/bash

source $HOME/src/borg/env.sh
OPTIONS="--repair --repository-only --lock-wait 30 --verbose"

yes YES | $HOME/src/borg/borg check $OPTIONS $VAULT || borg_notify "Verify unsuccessful!"

