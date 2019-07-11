#!/usr/bin/env dash

# Update packages with the DNF package manager on Fedora
start_time=$(date '+%s')

echo '=====UPDATE: updating dnf packages======'
sudo dnf upgrade --refresh -y --allowerasing
# Commented out the line below because it unnecessarily downgrades some packages
# sudo dnf distro-sync -y --allowerasing
echo '=====UPDATE: autoremoving packages======'
sudo dnf autoremove -y --allowerasing
echo '=====UPDATE: caching repos=============='
dnf makecache

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
