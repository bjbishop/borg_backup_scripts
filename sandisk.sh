#!/usr/local/bin/bash

LOCKFILE=~/.borg_backup_in_process
if [ -f "$LOCKFILE" ]
then
    echo "Another backup is running"
    exit 0
else
    touch $LOCKFILE
fi

! [[ -d /Volumes/sandisk/ ]] && exit 0

mkdir -p ~/src/borg/logs
chown bishbr ~/src/borg/logs
export PATH=/usr/local/bin:$PATH
export BORG_RELOCATED_REPO_ACCESS_IS_OK=yes
export BORG_PASSCOMMAND="security -q find-generic-password -l 'borgmatic version1' -w"

nice /usr/local/bin/borgmatic -c $HOME/src/borg/sandisk.yaml -v 1
\rm -f ~/.borg_backup_in_process
