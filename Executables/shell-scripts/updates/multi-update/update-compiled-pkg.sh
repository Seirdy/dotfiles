#!/bin/dash

# Updates that involve compiling packages
cd ~/Executables/shell-scripts/updates
echo "===UPDATE: Upgrading: go packages======="
dash ./updatego.sh
echo "===UPDATE: Upgrading: Cargo packages======="
dash ./updatecargo.sh
