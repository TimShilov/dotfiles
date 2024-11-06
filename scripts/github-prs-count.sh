#!/bin/bash

bkt --ttl=10m -- gh search prs --review-requested=@me --state=open --json=url |
    jq '.[].url' |
    wc -l |
    awk '{print $1}'
