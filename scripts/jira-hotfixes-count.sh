#!/bin/bash

bkt --ttl=10m --discard-failures -- \
    jira issues list -a $(jira me) -s~Done \
    -q "project IS NOT EMPTY AND type = HotFix" \
    --plain --no-headers \
    2>&1 |
    grep -v "No result found for given query" |
    grep -c "."
