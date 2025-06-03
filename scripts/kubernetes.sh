#!/bin/bash

k9s --context=$(kubectl config get-contexts --no-headers | sed 's/*//' | awk '{ print $1}' | fzf)
