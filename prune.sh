#!/usr/local/bin/bash

KEEP_THESE_DAYS=14
KEEP_ALL_WITHIN_DAYS=1d
PRUNE_OPTIONS="--list --stats --verbose"
source $HOME/src/borg/env.sh
mkdir -p $BORG_MANIFESTS_HOME

nice /usr/local/bin/borg prune $PRUNE_OPTIONS -d $KEEP_THESE_DAYS --keep-within $KEEP_ALL_WITHIN_DAYS $VAULT || borg_notify "Pruning unsuccessful!"
find $BORG_MANIFESTS_HOME -type f -mtime -$KEEP_THESE_DAYS -delete
