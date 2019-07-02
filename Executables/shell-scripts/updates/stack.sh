#!/usr/bin/env dash

start_time=$(date '+%s')

stack_install() {
        stack --local-bin-path="$HOME/Executables/stack/bin" install "$@" -v
}
stack config set resolver nightly
stack upgrade
stack_install pandoc
stack_install pandoc-citeproc
stack_install ShellCheck
stack_install pandoc-include-code
stack_install pandoc-crossref

end_time=$(date '+%s')
elapsed=$(echo "${end_time} - ${start_time}" | bc)
echo "Time elapsed: ${elapsed} seconds"
