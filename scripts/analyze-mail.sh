#!/usr/bin/env bash

FILTER=${1:-'*'}

echo 'Messages by mailbox:'
notmuch search --output=files "$FILTER" |
  while IFS= read -r file; do dirname "$file"; done |
  sed -E 's:/(cur|new)$::' |
  sort |
  uniq -c |
  sort -nr |
  awk '{count=$1; $1=""; sub(/^ /, ""); sum+=count; print count, $0} END {print sum, "total"}'

echo "-------------------"
echo 'Top 10 most frequent senders:'
for sender in $(notmuch address --output=address --deduplicate=address "$FILTER"); do
  count=$(notmuch count from:"$sender")
  echo "$count $sender"
done | sort -nr | head -n 10
