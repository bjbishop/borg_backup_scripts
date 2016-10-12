#!/usr/bin/env bash

source $HOME/src/borg/env.sh
ITEM=`uuidgen | tail -c 10`
mkdir -p $BORG_MANIFESTS_HOME

# osascript -e "tell application \"Box Sync\" to activate"
# sleep 30

nice /usr/local/bin/borg create $OPTIONS $VAULT::$ITEM $HOME &> $BORG_MANIFESTS_HOME/$ITEM.txt || borg_notify "Alert! Backup unsuccessful!" && borg_notify "Backup completed successfully"
$HOME/src/borg/prune.sh

nice /usr/local/bin/xz -9 $BORG_MANIFESTS_HOME/$ITEM.txt

# sleep 90
# osascript -e "tell application \"Box Sync\" to quit"
