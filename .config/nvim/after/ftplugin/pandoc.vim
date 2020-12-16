scriptencoding utf-8
command! -nargs=0 Format :lua vim.lsp.buf.formatting()
" :IndentLinesDisable
let s:cchars = {
			\'newline': '↵',
			\'image': '',
			\'super': 'ⁿ',
			\'sub': 'ₙ',
			\'strike': 'x̶',
			\'atx': '§',
			\'codelang': '',
			\'codeend': '—',
			\'abbrev': '→',
			\'footnote': '†',
			\'definition': ' ',
			\'li': '•',
			\'html_c_s': '‹',
			\'html_c_e': '›'}
command! -nargs=0 -buffer -range=% Format2 let b:winview = winsaveview() |
			\ execute <line1> . "," . <line2> . "!pandoc -f markdown -t markdown-multiline_tables-raw_attribute+link_attributes-fenced_code_attributes -sp --columns=85 --tab-stop=2 --markdown-headings=setext" |
			\ call winrestview(b:winview)
cabbrev Format Format2
