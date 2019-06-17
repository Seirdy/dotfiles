#!/bin/dash

# Updates that involve compiling packages
cd ~/Executables/shell-scripts/updates
echo "===UPDATE: Upgrading: go packages======="
dash ./update-go.sh
echo "===UPDATE: Upgrading: Cargo packages======="
dash ./update-cargo.sh
