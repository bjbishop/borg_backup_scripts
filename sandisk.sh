#!/usr/local/bin/bash

LOCKFILE=~/.borg_backup_in_process
AUDIT_LOG=~/src/borg/logs/audit.log
VOLUME=/Volumes/sandisk

if [ -f "$LOCKFILE" ]
then
    printf "\tAnother backup is running\n"
    printf "$0\ttried to start on $(date)\n" >> $AUDIT_LOG
    exit 0
else
    printf "$0\tstarted on $(date)\n" > $LOCKFILE
    printf "$0\tstarted on $(date)\n" >> $AUDIT_LOG
fi

if ! [[ -d "$VOLUME" ]]
then
    printf "$0\twas prevented from running on $(date) because $VOLUME was not present\n" >> $AUDIT_LOG
    \rm -f "$LOCKFILE"
    exit 0
fi


mkdir -p ~/src/borg/logs
chown bishbr ~/src/borg/logs
export PATH=/usr/local/bin:$PATH
export BORG_RELOCATED_REPO_ACCESS_IS_OK=yes
export BORG_PASSCOMMAND="security -q find-generic-password -l 'borgmatic version1' -w"

nice /usr/local/bin/borgmatic -c "$HOME/src/borg/sandisk.yaml" -v 1
\rm -f "$LOCKFILE"
printf "$0\tstopped on $(date)\n" >> "$AUDIT_LOG"
