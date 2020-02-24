so pandoc.vim

" format but without fenced code attributes
command! -nargs=0 -buffer -range=% Format let b:winview = winsaveview() |
	\ execute <line1> . "," . <line2> . "!pandoc --from=markdown --to=markdown-multiline_tables-fenced_code_attributes --standalone --columns=85 --preserve-tabs --tab-stop=2" . &shiftwidth |
	\ call winrestview(b:winview)
