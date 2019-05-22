#!/usr/bin/env bash
#shellcheck disable=SC2039
set -e -u -o pipefail
command -v tmutil &> /dev/null

SNAPSHOT_DIR="/private/tmp/borgbackup"
mkdir -p "$SNAPSHOT_DIR"
if [ -d "$SNAPSHOT_DIR/Users" ]
then
    echo "$SNAPSHOT_DIR already mounted?"
    diskutil unmount "$SNAPSHOT_DIR" || \
	diskutil unmount "$SNAPSHOT_DIR" || \
	diskutil unmount force "$SNAPSHOT_DIR" || exit 1
fi

TIMESTAMP=$(tmutil localsnapshot | awk -F ":" ' { print $2 } ' | tr -d "[:space:]")
echo "Created a snapshot with timestamp: $TIMESTAMP"
mount_apfs -s com.apple.TimeMachine."${TIMESTAMP}" / "$SNAPSHOT_DIR"
tmutil listlocalsnapshots /
test -d "$SNAPSHOT_DIR/Users/bishbr"
