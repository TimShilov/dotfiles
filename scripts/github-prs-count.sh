#!/bin/bash

bkt --ttl=10m --discard-failures -- gh search prs --review-requested=@me --state=open --json=url |
    jq '.[].url' |
    grep -c "."
