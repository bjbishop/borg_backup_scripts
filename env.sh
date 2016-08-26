function borg_notify() {
    command -v terminal-notifier || brew install terminal-notifier
    terminal-notifier -title "BACKUP ERROR" -subtitle "From BorgBackup" -message Hi -appIcon `pwd`/borglogo.png -message "$1" -execute "open -a TextEdit -- $BORG_HOME/launchctl.err"
}

VAULT=/Volumes/Bytor/box/borg
BORG_HOME=$HOME/src/borg
BORG_MANIFESTS_HOME=$BORG_HOME/manifests
EXCLUDE=$BORG_HOME/exclude
OPTIONS="--exclude-from $EXCLUDE --one-file-system --verbose --stats --compression zlib"
