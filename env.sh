VAULT=/Volumes/Bytor/box/borg
BORG_HOME=$HOME/src/borg
BORG_MANIFESTS_HOME=$BORG_HOME/manifests
EXCLUDE=$BORG_HOME/exclude
OPTIONS="--exclude-from $EXCLUDE --one-file-system --verbose --stats --compression zlib --list --lock-wait 60 --exclude-if-present .borgexclude"

function borg_notify() {
    command -v terminal-notifier > /dev/null || brew install terminal-notifier
    terminal-notifier -title "BORG BACKUP" -message Hi -appIcon `pwd`/borglogo.png -message "$1" -execute "open -a TextEdit -- $BORG_HOME/launchctl.err"
}

export -f borg_notify
