#!/usr/bin/env bash

set -e

mkdir -p ~/src/borg/logs
chown bishbr ~/src/borg/logs
open -g -a Anybar
export PATH=/usr/local/bin:$PATH
export BORG_RELOCATED_REPO_ACCESS_IS_OK=yes
export BORG_PASSCOMMAND="security -q find-generic-password -l 'borgmatic version1' -w"

mount -t smbfs //bishbr@icdwpcoredfs01.peroot.com/Share/1st%20Temp/bishbr ~/1st_temp
mkdir -p ~/1st_temp/borg
nice /usr/local/bin/borgmatic -c $HOME/src/borg/borgmatic-qdrive.yaml && umount ~/1st_temp
