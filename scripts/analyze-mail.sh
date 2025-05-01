#!/usr/bin/env bash

echo 'Messages by mailbox:'
notmuch search --output=files a |
  while IFS= read -r file; do dirname "$file"; done |
  sort |
  uniq -c |
  sort -nr |
  awk '{count=$1; $1=""; sub(/^ /, ""); sum+=count; print count, $0} END {print sum, "total"}'

echo 'Top 10 most frequent senders:'
for sender in $(notmuch address --output=address --deduplicate=address '*'); do
  count=$(notmuch count from:"$sender")
  echo "$count $sender"
done | sort -nr | head -n 10
