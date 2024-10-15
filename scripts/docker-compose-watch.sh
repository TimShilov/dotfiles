#!/bin/bash

# Function to detect the compose command
detect_compose_command() {
    if command -v podman-compose &>/dev/null; then
        echo "podman-compose"
    elif command -v docker-compose &>/dev/null; then
        echo "docker-compose"
    else
        echo "Neither podman-compose nor docker-compose found. Exiting."
        exit 1
    fi
}

# Detect the compose command
COMPOSE_CMD=$(detect_compose_command)
# Parse arguments
COMPOSE_ARGS=""
while [[ $# -gt 0 ]]; do
    case $1 in
    *)
        COMPOSE_ARGS="$COMPOSE_ARGS $1"
        shift
        ;;
    esac
done

# Function to run compose down
compose_down() {
    echo "Running compose down..."
    $COMPOSE_CMD $COMPOSE_ARGS down
}

TEMP_FILE=$(mktemp)

# Set up a trap to ensure compose down is called when the script exits
trap 'compose_down; rm $TEMP_FILE; exit' SIGINT SIGTERM

# Start compose up
$COMPOSE_CMD $COMPOSE_ARGS up --force-recreate &

# Function to check for inactivity and stop if needed
check_inactivity() {
    current_time=$(date +%s)
    last_change=$(stat -f %m $TEMP_FILE)

    time_diff=$((current_time - last_change))

    if [ $time_diff -ge 600 ]; then
        echo "No file changes detected for 10 minutes. Stopping containers..."
        compose_down
        exit 0
    fi
}

# Watch for file changes
fswatch -o -r --exclude time.log . | while read f; do
    echo $f >$TEMP_FILE
done &

# Main loop to periodically check for inactivity
while true; do
    sleep 5
    check_inactivity
done
