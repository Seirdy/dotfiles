#!/usr/bin/env dash

start_time=$(date '+%s')

stack install pandoc pandoc-citeproc pandoc-crossref pandoc-include-code ShellCheck

end_time=$(date '+%s')
elapsed=$(echo "${end_time} - ${start_time}" | bc)
echo "Time elapsed: ${elapsed} seconds"
