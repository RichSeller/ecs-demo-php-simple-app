#!/usr/bin/env bash
echo "Polling env for secrets:"

_handleSignal() {
  echo "Exiting, goodbye!"
  exit 0
}

# Handle SIGTERM and SIGINT so that our script
# can be stopped when trying to kill the pod
# gracefully.
trap _handleSignal SIGTERM SIGINT

# Keep printing our secrets
while true; do
  env | grep "^DB\|^API\|^SERVICE"
  sleep 1
done