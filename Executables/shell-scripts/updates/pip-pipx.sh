#!/usr/bin/env dash

start_time=$(date '+%s')

pip3 install -U --user git+https://github.com/pipxproject/pipx.git
pip3 install -U --user pynvim
pipx upgrade-all

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
