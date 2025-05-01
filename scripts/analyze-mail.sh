#!/usr/bin/env bash

echo 'Messages by mailbox:'
notmuch search --output=files '*' | xargs -n1 dirname | sort | uniq -c | sort -nr  | awk '{sum += $1; print} END {print sum, "total"}'

echo 'Top 10 most frequent senders:'
for sender in $(notmuch address --output=address --deduplicate=address '*'); do
    count=$(notmuch count from:"$sender")
    echo "$count $sender"
done | sort -nr | head -n 10
