#!/usr/local/bin/bash

set -e

! [[ -d /Volumes/Redsandisk/ ]] && exit 0

mkdir -p ~/src/borg/logs
chown bishbr ~/src/borg/logs
export PATH=/usr/local/bin:$PATH
export BORG_RELOCATED_REPO_ACCESS_IS_OK=yes
export BORG_PASSCOMMAND="security -q find-generic-password -l 'borgmatic version1' -w"

CMD="nice /usr/local/bin/borgmatic -c $HOME/src/borg/borgmatic-redsandisk.yaml"
$CMD || $CMD
