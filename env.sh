VAULT=/Volumes/Bytor/box/borg
BORG_HOME=$HOME/src/borg
BORG_MANIFESTS_HOME=$BORG_HOME/manifests
EXCLUDE=$BORG_HOME/exclude
OPTIONS="--exclude-from $EXCLUDE --one-file-system --verbose --stats --compression zlib --list --lock-wait 60"
