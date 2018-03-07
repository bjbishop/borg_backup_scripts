#!/usr/local/bin/bash

export PATH=/usr/local/bin:$PATH
export BORG_REPO=~/box/borgmatic
export BORG_RELOCATED_REPO_ACCESS_IS_OK=yes
export BORG_PASSCOMMAND="security -q find-generic-password -l 'borgmatic version1' -w"
/usr/local/bin/borgmatic -c ~/src/borg/borgmatic-box.yaml -v 1
