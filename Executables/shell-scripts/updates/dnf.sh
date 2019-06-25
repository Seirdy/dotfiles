#!/usr/bin/env dash

# Update packages with the DNF package manager on Fedora
STARTTIME=$(date '+%s')

echo '=====UPDATE: updating dnf packages======'
sudo dnf upgrade --refresh -y --allowerasing
# Commented out the line below because it unnecessarily downgrades some packages
# sudo dnf distro-sync -y --allowerasing
echo '=====UPDATE: autoremoving packages======'
sudo dnf autoremove -y --allowerasing
echo '=====UPDATE: caching repos=============='
dnf makecache

ENDTIME=$(date '+%s')
ELAPSED=$(echo "${ENDTIME} - ${STARTTIME}" | bc)
echo "Time elapsed: ${ELAPSED} seconds"
