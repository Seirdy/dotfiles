" json comment highlighting
syntax match Comment +\/\/.\+$+
" Format with jq
command! -nargs=0 -buffer -range=% Format let b:winview = winsaveview() |
			\ execute <line1> . "," . <line2> . "!jq -M --tab ." |
			\ call winrestview(b:winview)
