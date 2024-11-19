#!/bin/sh

source "$CONFIG_DIR/colors.sh" # Loads all defined colors

TASK_CMD="task rc.gc=off"
CACHE_CMD="bkt --ttl=1m --discard-failures --"
JIRA_TICKET_COUNT=$($TASK_CMD jiraid +READY count)
JIRA_HOTFIX_COUNT=$($TASK_CMD jiraissuetype:HotFix +READY count)

LABEL="$JIRA_TICKET_COUNT"
COLOR="$BLUE"

if [ "$JIRA_HOTFIX_COUNT" -gt 0 ]; then
    LABEL="$JIRA_HOTFIX_COUNT $JIRA_TICKET_COUNT"
    COLOR="$RED"
fi

sketchybar --set "$NAME" \
    icon="󰌃 " icon.color="$COLOR" \
    label="$LABEL" \
    label.color="$COLOR"
