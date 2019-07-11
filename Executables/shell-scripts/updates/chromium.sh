#!/usr/bin/env dash

start_time=$(date '+%s')

dash "$HOME/Executables/chromium-latest-linux/update.sh"

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
