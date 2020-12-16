#!/usr/bin/env dash
# based on https://github.com/wfxr/tmux-fzf-url/blob/master/fzf-url.sh

fzf_cmd() {
	fzf-tmux -w 100% -h 35% -y 56 -- --multi --exit-0 --cycle --reverse --bind='ctrl-r:toggle-all' --bind='ctrl-s:toggle-sort' --no-preview
}

urls="rg -o '(https?|ftp|file|gemini|gopher):/?//[-A-Za-z0-9+&@#/%?=~_|!:,.;]*[-A-Za-z0-9+&@#/%=~_|]'"
wwws="rg -o 'www\.[a-zA-Z](-?[a-zA-Z0-9])+\.[a-zA-Z]{2,}(/\S+)*' --replace 'http://\$0'"
ips="rg -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}(:[0-9]{1,5})?(/\S+)*' --replace 'http://\$0'"
gits="rg -o '(ssh://)?(git@)(\S*):(\S*)' --replace 'https://\$3/\$4'"
matches() {
	tmux capture-pane -J -p | pee "$urls" "$wwws" "$ips" "$gits"
}

matches \
	| sort \
	| uniq \
	| nl -w3 -s '  ' \
	| fzf_cmd \
	| awk '{print $2}' \
	| wl-copy -nt text/plain \
	|| true
