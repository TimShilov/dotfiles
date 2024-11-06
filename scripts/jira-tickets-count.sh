#!/bin/bash

bkt --ttl=10m -- \
    jira issues list -a $(jira me) \
    -q "project IS NOT EMPTY" \
    --plain --no-headers |
    wc -l |
    awk '{print $1}'
