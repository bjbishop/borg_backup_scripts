#!/usr/local/bin/bash

source $HOME/src/borg/env.sh
export PATH=/usr/local/bin:$PATH

ITEM=`uuidgen | tail -c 10`
mkdir -p $BORG_MANIFESTS_HOME

# osascript -e "tell application \"Box Sync\" to activate"
# sleep 30

borg_notify "Backup starting now."

\borg create $OPTIONS $VAULT::$ITEM $HOME &> $BORG_MANIFESTS_HOME/$ITEM.txt
RETVAL=$?

# https://github.com/borgbackup/borg/issues/871
if [ $RETVAL -eq 0 ] || [ $RETVAL -eq 1 ];
then
    borg_notify "Backup completed successfully"
else
    borg_notify "Alert! Backup failed!"
fi

$HOME/src/borg/prune.sh

nice /usr/local/bin/xz -9 $BORG_MANIFESTS_HOME/$ITEM.txt

# sleep 90
# osascript -e "tell application \"Box Sync\" to quit"
