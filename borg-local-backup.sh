#!/usr/local/bin/bash

export BORG_HOME=$HOME/src/borg
source $BORG_HOME/env.sh
export VAULT=/Volumes/sandisk/borg-backup
export BORG_MANIFESTS_HOME=$BORG_HOME/manifests
export EXCLUDE=$BORG_HOME/exclude
export OPTIONS="--exclude-from $EXCLUDE --one-file-system --verbose --stats --compression lzma --list --lock-wait 60 --exclude-if-present .borgexclude"
export KEEP_THESE_DAYS=2

# Just quit if the usb drive isn't there
if ! [ -d /Volumes/sandisk ];
then
    borg_notify "Backup not started, Sandisk not present"
    exit 0
fi

sudo mkdir -p $VAULT > /dev/null
sudo chown $USER:staff $VAULT

$BORG_HOME/borg.sh
