#!/bin/bash

bkt --ttl=10m --discard-failures -- gh search prs --review-requested=@me --state=open --json=url |
    jq '.[].url' |
    wc -l |
    awk '{print $1}'
