#!/bin/bash

bkt --ttl=10m --discard-failures -- \
    jira issues list -a $(jira me) -s~Done \
    -q "project IS NOT EMPTY" \
    --plain --no-headers |
    grep -c "."
