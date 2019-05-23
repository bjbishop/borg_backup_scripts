#!/usr/bin/env bash

export PATH=/usr/local/bin:$PATH
export BORG_RELOCATED_REPO_ACCESS_IS_OK=yes
export BORG_PASSCOMMAND="security -q find-generic-password -l 'borgmatic version1' -w"

umount ~/1st_temp/ || true
set -e

echo "Testing the Q drive to see if the repo exists"
mount -t smbfs //bishbr@icdwpcoredfs01.peroot.com/Share/1st%20Temp ~/1st_temp
if ! [ -d ~/1st_temp/bishbr ]
then
    echo "Repo does not exist, recreating..."
    mkdir -p ~/1st_temp/bishbr
    borg init --progress --verbose --encryption=keyfile-blake2 ~/1st_temp/bishbr/borg
    umount ~/1st_temp
fi

mkdir -p ~/src/borg/logs
chown bishbr ~/src/borg/logs
open -g -a Anybar

mount -t smbfs //bishbr@icdwpcoredfs01.peroot.com/Share/1st%20Temp/bishbr ~/1st_temp
if [ -d ~/1st_temp/borg ]
then
    nice /usr/local/bin/borgmatic -c "$HOME/src/borg/qdrive.yaml"
    umount ~/1st_temp
fi

