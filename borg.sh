#!/usr/local/bin/bash

source $HOME/src/borg/env.sh
export PATH=/usr/local/bin:$PATH

ITEM=`uuidgen | tail -c 10`
mkdir -p $BORG_MANIFESTS_HOME

function borg_notify() {
    command -v terminal-notifier > /dev/null || brew install terminal-notifier
    terminal-notifier -title "BORG BACKUP" -message Hi -appIcon `pwd`/borglogo.png -message "$1" -execute "open -a TextEdit -- $BORG_HOME/launchctl.err"
}

osascript -e "tell application \"Box Sync\" to activate"
# sleep 30

# borg_notify "Backup starting now."

/usr/local/bin/borg create $OPTIONS $VAULT::$ITEM $HOME &> $BORG_MANIFESTS_HOME/$ITEM.txt
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
