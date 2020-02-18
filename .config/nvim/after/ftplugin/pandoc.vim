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
nmap <leader>w :Format<CR>mz:1,$!pandoc --from=markdown --to=markdown-multiline_tables --standalone --columns=84 --preserve-tabs --tab-stop=2<CR>`z:w<CR>
