" ================
" General Settings
" ================

filetype plugin on
set updatetime=300
set backspace=indent,eol,start
set autoread                       " Live-reloading
set ignorecase                     " Case-insensitive search
set smartcase
set wildmenu
set wildmode=list:longest,full
set mouse=a

"" Default formatting when not detected
set smartindent
set tabstop=4

" I like splitting windows side-by-side.
" On a laptop screen, my terminal often has 95 columns.
" 95 cols - 2 diagnostic cols - 4 number cols - 2 sign cols - 1 folding col
" - 1 padding col = 86 cols
set colorcolumn=86

" Remove trailing whitespace on save
autocmd! BufWritePre * :%s/\s\+$//e 

" =======
" Plugins
" =======

call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/vim-plug'
" General plugins
" ~~~~~~~~~~~~~~~
Plug 'tpope/vim-surround'  " Commands for matching pairs
Plug 'townk/vim-autoclose'  " Auto-match pairs in insert mode
Plug 'tpope/vim-commentary'  " Polygot keybinds for commenting code
Plug 'dhruvasagar/vim-table-mode', {'for': ['rst', 'pandoc']}  " Build ascii tables
" Appearance Plugins
" ~~~~~~~~~~~~~~~~~~
Plug 'ryanoasis/vim-devicons'  " File icons: works with vim-ariline.
Plug 'vim-airline/vim-airline'  " Like powerline
Plug 'fneu/breezy'  " Exactly like breeze theme for ktexteditor
" Plug 'luochen1990/rainbow'  " Colorize brackets and operators
" Coc Plugins
" ~~~~~~~~~~~
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

" Language-specific
" ~~~~~~~~~~~~~~~~~
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': 'pandoc' }
" Plug 'numirias/semshi', { 'for': 'python' }  " Better python syntax highlighting.
" coc-neco has been replaced by coc-vimlsp
Plug 'lervag/vimtex', {'for': ['plaintex', 'tex', 'pandoc']}  " works with coc.nvim via coc-vimtex
Plug   'KeitaNakamura/tex-conceal.vim', {'for': ['plaintex', 'tex', 'pandoc']}

call plug#end()

" =========
" Functions
" =========

" Easily switch conceal levels
function! SwitchConcealLevel()
		if &conceallevel == 0
				setlocal conceallevel=1
		elseif &conceallevel == 1
				setlocal conceallevel=2
		elseif &conceallevel == 2
				setlocal conceallevel=0
		endif
endfunction

" Used in coc > Completions
function! s:check_back_space() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" ============
" Gen. Keymaps
" ============

" Keymaps for coc features are in a dedicated section.

let mapleader = ','  " better than backslash imo
" hide search
nmap <silent> <leader><Space> :nohls<CR>
" If hiding search wasn't enough for you
nnoremap <silent> <C-l> :nohl<CR><C-l>
" Indent entire document with eqcmd. Alternative to :Format
nnoremap <F7> gg=G<C-o><C-o>
" Toggle conceal level
nnoremap <silent> <C-c><C-y> :call SwitchConcealLevel <CR>
" Toggle invisible chars
nnoremap <leader>l :set list!<CR>

" keep text selected after indentation
vnoremap < <gv
vnoremap > >gv

" Buffer management
" ~~~~~~~~~~~~~~~~~

" Buffer switching
nnoremap <tab> :bnext<CR>
nnoremap <s-tab> :bprevious<CR>
" New buffer
nnoremap <leader>bn :enew<cr>
" close buffer
nnoremap <leader>bq :bp <bar> bd! #<cr>
" close all buffers
nnoremap <leader>bQ :bufdo bd! #<cr>
" List buffers 
nnoremap <silent> <space>b :<C-u>CocList buffers<cr>

" ==========
" Appearance
" ==========

set background=light  " Necessary for breezy theme
colorscheme breezy
" Use 24-bit (true-color) mode in Vim/Neovim
" (see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more.)
if (has("nvim"))
		let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
		set termguicolors
endif

set number  " Show line number column
set signcolumn=yes  " for vim-pandoc-syntax and vim-signify
" set cursorline  " Commented out because it slows (n)vim down.
set lazyredraw
set pumblend=20  " translucent pum
set scrolloff=3

" Airline
" ~~~~~~~
set noshowmode  " Airline handles this
let g:airline_powerline_fonts = 1
let g:airline#extensions#disable_rtp_load = 1
let g:airline_highlighting_cache = 1
let g:webdevicons_enable_airline_statusline = 1
let g:airline_extensions = ['branch', 'tabline', 'coc']
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
" colorscheme
let g:rainbow_active = 1  " Rainbow brackets
let g:indentLine_char = "\uE621"  " dotted line  from powerline-patched-fonts
" Language-specific theme settings
let g:pymode_python = 'python3'  " Make sure python3 is used
let python_highlight_all = 1
let g:airline_theme = 'breezy'

" :terminal colors
" ~~~~~~~~~~~~~~~~

set t_Co=256
" black
let g:erminal_color_0 = '#31363b'
let g:erminal_color_8 = '#6a6e71'

" red                          
let g:erminal_color_1 = '#ed1515'
let g:erminal_color_9 = '#c0392b'

" green                        
let g:erminal_color_2 = '#11d116'
let g:erminal_color_10 = '#1cdc9a'

" yellow                       
let g:erminal_color_3 = '#f67400'
let g:erminal_color_11 = '#fdbc4b'

" blue                         
let g:erminal_color_4 = '#1d99f3'
let g:erminal_color_12 = '#3daee9'

" magenta                      
let g:erminal_color_5 = '#9b59b6'
let g:erminal_color_13 = '#8e44ad'

" cyan                         
let g:erminal_color_6 = '#1abc9c'
let g:erminal_color_14 = '#16a085'

" white                        
let g:erminal_color_7 = '#eff0f1'
let g:erminal_color_15 = '#ffffff'

" ======================================================
" Coc.nvim: Language Server Client and VSCode extensions
" ======================================================

" Completion
" ~~~~~~~~~~

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
						\ pumvisible() ? "\<C-n>" :
						\ <SID>check_back_space() ? "\<TAB>" :
						\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Navigation
" ~~~~~~~~~~

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" codeAction
" ~~~~~~~~~~

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)

" Documentation
" ~~~~~~~~~~~~~

" Use K for show documentation in preview/floating window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
		if &filetype == 'vim'
				execute 'h '.expand('<cword>')
		else
				call CocAction('doHover')
		endif
endfunction

augroup coc_stuff
		autocmd!
		" Update signature help on jump placeholder (useful for floating
		" window)
		autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Formatting
" ~~~~~~~~~~

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Format entire doc with langserver and write
nmap <leader>w :Format<CR>:w<CR>

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Other
" ~~~~~

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" don't give |ins-completion-menu| messages.
" set shortmess+=c

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Coc Snippets
" ~~~~~~~~~~~~

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" CocList
" ~~~~~~~

" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Git status
nnoremap <silent> <space>g  :<C-u>CocList --normal gstatus<CR>
" List snippets of current file
nnoremap <silent> <space>n  :<C-u>CocList <cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" ==========
" Table Mode
" ==========

function! s:isAtStartOfLine(mapping)
		let text_before_cursor = getline('.')[0 : col('.')-1]
		let mapping_pattern = '\V' . escape(a:mapping, '\')
		let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
		return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
						\ <SID>isAtStartOfLine('\|\|') ?
						\ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
						\ <SID>isAtStartOfLine('__') ?
						\ '<c-o>:silent! TableModeDisable<cr>' : '__'

let g:table_mode_corner_corner='+'
let g:table_mode_header_fillchar='='
let g:table_mode_align_char='+'

let g:pandoc#syntax#codeblocks#embeds#langs=["c", "python3", "python", "py", "sh", "asm", "yaml", "html", "css"]
let g:pandoc#formatting#mode = 'h'
let g:pandoc#formatting#textwidth = 88
let g:pandoc#modules#disabled = ["folding","formatting"]
let g:pandoc#syntax#conceal#cchar_overrides = {"codelang": ""}
