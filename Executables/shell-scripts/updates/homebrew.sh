#!/usr/bin/env dash

start_time=$(date '+%s')

brew update
brew upgrade
brew cask upgrade

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
