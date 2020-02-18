nmap <leader>w :Format<CR>mz:1,$!shfmt -ci -s -bn<CR>`z:w<CR>
setlocal omnifunc=v:lua.vim.lsp.omnifunc
