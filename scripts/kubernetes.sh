#!/bin/bash

k9s --insecure-skip-tls-verify \
    --context=$(kubectl config get-contexts --no-headers | sed 's/*//' | awk '{ print $1}' | fzf)
