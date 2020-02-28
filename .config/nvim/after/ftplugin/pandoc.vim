" :IndentLinesDisable
let s:cchars = {
	\"newline": "↵",
	\"image": "",
	\"super": "ⁿ",
	\"sub": "ₙ",
	\"strike": "x̶",
	\"atx": "§",
	\"codelang": "",
	\"codeend": "—",
	\"abbrev": "→",
	\"footnote": "†",
	\"definition": " ",
	\"li": "•",
	\"html_c_s": "‹",
	\"html_c_e": "›"}

command! -nargs=0 -buffer -range=% Format let b:winview = winsaveview() |
	\ execute <line1> . "," . <line2> . "!pandoc --from=markdown --to=markdown-multiline_tables-raw_attribute --standalone --columns=85 --preserve-tabs --tab-stop=2" |
	\ call winrestview(b:winview)
