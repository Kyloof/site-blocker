#!/bin/bash

# Input
REAL_PATH=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$REAL_PATH")

MODE=$1
if [[ -z $MODE || -z $2 ]]; then
    echo "Usage: block [block_mode] [duration]"
    echo "block_list - previously specified list for blocking sites"
    echo "duration - duration of the block in minutes"
    exit 1
fi
DURATION=$(( $2 * 60 ))

# Paths
HOSTS_FILE="/etc/hosts"
BLOCK_LIST="$SCRIPT_DIR/block_options/$MODE"
BACKUP_FILE="$SCRIPT_DIR/tmp/hosts.bak"

if [ ! -f $BLOCK_LIST ]; then
    echo "Error: Given block list doesn't exist"
    echo "block_list - previously specified list for blocking sites"
    exit 1
fi

# Trap
cleanup () {
    echo "Timer is up!"
    mv "$BACKUP_FILE" "$HOSTS_FILE"
}
trap cleanup EXIT

# Backup
cp "$HOSTS_FILE" "$BACKUP_FILE"

# Block the sites
cat "$BLOCK_LIST" >> "$HOSTS_FILE"

sleep $DURATION
