# dnf clean all
STARTTIME=$(date '+%s')
sudo dnf upgrade --refresh -y --allowerasing
# sudo dnf distro-sync -y --allowerasing
sudo dnf autoremove -y --allowerasing
echo "===UPDATE: Caching packages======"
dnf makecache
ENDTIME=$(date '+%s')
ELAPSED=$(calc -p "${ENDTIME} - ${STARTTIME}")
echo "Time elapsed: ${ELAPSED} seconds"
