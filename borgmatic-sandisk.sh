#!/usr/local/bin/bash

set -e

if ! [[ -d /Volumes/sandisk/ ]]
then
    exit 0
fi

mkdir -p ~/src/borg/logs
chown bishbr ~/src/borg/logs
export PATH=/usr/local/bin:$PATH
export BORG_RELOCATED_REPO_ACCESS_IS_OK=yes
export BORG_PASSCOMMAND="security -q find-generic-password -l 'borgmatic version1' -w"

CMD="nice /usr/local/bin/borgmatic -c $HOME/src/borg/borgmatic-sandisk.yaml -v 1"
$CMD || $CMD
