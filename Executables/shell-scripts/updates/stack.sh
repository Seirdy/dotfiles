#!/usr/bin/env dash

start_time=$(date '+%s')

stack_local() {
	stack --local-bin-path="$HOME/Executables/stack/bin" "$@"
}
stack_install() {
	stack_local install "$@"
}

stack_local config set resolver nightly
stack_local upgrade
stack_local update
stack_install pandoc
stack_install pandoc-citeproc
stack_install ShellCheck
stack_install pandoc-include-code
stack_install pandoc-crossref

end_time=$(date '+%s')
elapsed=$(echo "$end_time - $start_time" | bc)
echo "Time elapsed: $elapsed seconds"
