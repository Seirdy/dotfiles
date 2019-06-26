#!/usr/bin/env dash

start_time=$(date '+%s')

stack install pandoc
stack install pandoc-citeproc
stack install pandoc-include-code
stack install ShellCheck
stack install pandoc-crossref

end_time=$(date '+%s')
elapsed=$(echo "${end_time} - ${start_time}" | bc)
echo "Time elapsed: ${elapsed} seconds"
