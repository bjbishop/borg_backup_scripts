#!/usr/bin/env bash
#shellcheck disable=SC2039
set -e -u -o pipefail
command -v tmutil &> /dev/null

SNAPSHOT_DIR="/private/tmp/borgbackup"
test -d "$SNAPSHOT_DIR"

diskutil unmount "$SNAPSHOT_DIR" || \
    diskutil unmount "$SNAPSHOT_DIR" || \
    diskutil unmount force "$SNAPSHOT_DIR"

SNAPSHOTS=$(tmutil listlocalsnapshots /)
for SNAPSHOT in $SNAPSHOTS
do
    SNAPSHOT_TIMESTAMP=$(echo "$SNAPSHOT" | tail -1 | awk -F "." ' { print $4 } ' | tr -d "[:space:]")
    tmutil deletelocalsnapshots "$SNAPSHOT_TIMESTAMP"
done
