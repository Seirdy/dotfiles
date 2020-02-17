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
nmap <leader>w :%s/\s\+$//e<CR>:1,$!pandoc-format-md<CR>:w<CR>
