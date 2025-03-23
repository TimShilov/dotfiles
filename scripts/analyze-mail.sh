#!/usr/bin/env bash

echo 'Top 10 most frequent senders:'
for sender in $(notmuch address --output=address --deduplicate=address '*'); do
    count=$(notmuch count from:"$sender")
    echo "$count $sender"
done | sort -nr | head -n 10
