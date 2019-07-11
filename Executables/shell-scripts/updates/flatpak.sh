#!/usr/bin/env dash

start_time=$(date '+%s')

flatpak repair --user
flatpak update -y --user
flatpak uninstall --unused -y

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
