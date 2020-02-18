setlocal tabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal autoindent
setlocal smarttab
setlocal conceallevel=2
command! -nargs=0 Format :lua vim.lsp.buf.formatting()
" nmap <leader>w :Format<CR>mz:1,$!pandoc --from=markdown --to=markdown-multiline_tables --standalone --columns=84 --preserve-tabs --tab-stop=2<CR>`z:w<CR>
