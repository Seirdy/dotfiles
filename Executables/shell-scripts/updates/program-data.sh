#!/usr/bin/env dash

start_time=$(date '+%s')

echo 'tldr update'
tldr --update
echo 'Sync Pocket and Buku'
poku
# echo 'Update buku database'
# buku -u --threads 10
echo 'Updating RSS feeds'
newsboat -x reload

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
