#!/usr/bin/env bash

source $HOME/src/borg/env.sh
ITEM=`uuidgen | tail -c 10`
mkdir -p $BORG_MANIFESTS_HOME

osascript -e "tell application \"Box Sync\" to activate"
sleep 30

nice /usr/local/bin/borg create $OPTIONS $VAULT::$ITEM $HOME || borg_notify "Backup unsuccessful!"
$HOME/src/borg/prune.sh

/usr/local/bin/borg list $VAULT::$ITEM > $BORG_MANIFESTS_HOME/$ITEM.txt
nice xz -9 $BORG_MANIFESTS_HOME/$ITEM.txt
sleep 90
osascript -e "tell application \"Box Sync\" to quit"
