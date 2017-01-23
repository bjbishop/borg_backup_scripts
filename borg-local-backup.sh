#!/usr/local/bin/bash -l

source ~/.bashrc

source $HOME/src/borg/env.sh

KEEP_THESE_DAYS=2
VAULT=/Volumes/sandisk/borg-backup

# Just quit if the usb drive isn't there
if ! [ -d /Volumes/sandisk ];
then
    borg_notify "Backup not started, Sandisk not present"
    exit 0
fi

sudo mkdir $VAULT @> /dev/null
sudo chown $USER:staff $VAULT

$BORG_HOME/borg.sh
