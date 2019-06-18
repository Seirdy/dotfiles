#!/usr/bin/env dash

# Update packages with the DNF package manager on Fedora
STARTTIME=$(date '+%s')
sudo dnf upgrade --refresh -y --allowerasing
# Commented out the line below because it unnecessarily downgrades some packages
# sudo dnf distro-sync -y --allowerasing
sudo dnf autoremove -y --allowerasing
echo "===UPDATE: Caching packages======"
dnf makecache
ENDTIME=$(date '+%s')
ELAPSED=$(calc -p "${ENDTIME} - ${STARTTIME}")
echo "Time elapsed: ${ELAPSED} seconds"
