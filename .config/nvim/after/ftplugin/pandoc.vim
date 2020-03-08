scriptencoding utf-8
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

command! -nargs=0 Format :lua vim.lsp.buf.formatting()
