#!/bin/bash

# Input string from the command-line argument or default to a predefined value
input="${1}"

# TODO: Make it account for Timezone as well, right now it is simply ignored
# Extract the relevant date and time part, ignoring the timezone
datetime=$(echo "$input" | sed -E 's/^.* ([0-9]{4}-[0-9]{2}-[0-9]{2})[[:space:]]+([0-9]{2}:[0-9]{2}).*$/\1T\2/')

# Convert to Unix timestamp
timestamp=$(gdate -d "$datetime" +%s 2>/dev/null)
# Check if timestamp conversion was successful
if [ -z "$timestamp" ]; then
    echo "Error: Failed to parse date and time from input: $datetime"
    exit 2
fi

now_unix=$(date +%s)

if [ "$timestamp" -lt "$now_unix" ]; then
    exit 0
else
    exit 1
fi
