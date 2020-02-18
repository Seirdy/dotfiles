setlocal formatexpr=CocAction('formatSelected')
" json comment highlighting
syntax match Comment +\/\/.\+$+
setlocal omnifunc=v:lua.vim.lsp.omnifunc
