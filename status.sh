#!/usr/bin/env bash

export BORG_RELOCATED_REPO_ACCESS_IS_OK=yes
export BORG_PASSCOMMAND="security -q find-generic-password -l 'borgmatic version1' -w"

REPOS="/Users/bishbr/box/borgmatic
/Volumes/Redsandisk/borgmatic
/Volumes/sandisk/borgmatic"

for i in $REPOS
do
    echo "============================== Listing $i =============================="
    [[ -d $i ]] && borg list "$i"
done
