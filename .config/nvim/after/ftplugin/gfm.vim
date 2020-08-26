" format but without fenced code attributes
command! -nargs=0 -buffer -range=% Format2 let b:winview = winsaveview() |
	\ execute <line1> . "," . <line2> . "!pandoc -f markdown -t gfm -s --columns=85 --preserve-tabs --tab-stop=2" |
	\ call winrestview(b:winview)
cabbrev Format Format2
