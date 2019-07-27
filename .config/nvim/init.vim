" ================
" General Settings
" ================

filetype plugin on
set title
set updatetime=300
set backspace=indent,eol,start
set ignorecase                     " Case-insensitive search
set smartcase
set wildmenu
set wildmode=list:longest,full
set mouse=a
set regexpengine=2
set undofile
set undolevels=2000
set diffopt=vertical
set pumheight=18
set scrolloff=3
set cmdheight=2  " Useful for diagnostics
set number  " Show line number column
set grepprg=rg\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m
" set relativenumber
set shell=zsh
set signcolumn=yes  " for vim-pandoc-syntax and vim-signify

"" Default formatting when not detected
set smartindent
set shiftwidth=2
set tabstop=2  " Anything more than that is distracting.
" I like splitting windows side-by-side.
" On a laptop screen, my terminal often has 95 columns.
" 95 cols - 2 diagnostic cols - 4 number cols - 1 sign col - 1 folding col
" - 1 padding col - 1 cursorcolumn = 86 cols
set colorcolumn=86

" Spellfile
set spellfile=~/.config/nvim/spell/en.utf-8.add

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
Plug 'ConradIrwin/vim-bracketed-paste'  " Auto-sets paste
" Appearance Plugins
" ~~~~~~~~~~~~~~~~~~
Plug 'ryanoasis/vim-devicons'  " File icons: works with vim-ariline.
Plug 'vim-airline/vim-airline'  " Like powerline
Plug 'fneu/breezy'  " Exactly like breeze theme for ktexteditor
Plug 'rakr/vim-one'
" Plug 'luochen1990/rainbow'  " Colorize brackets and operators
" Coc Plugins
" ~~~~~~~~~~~
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'tjdevries/coc-zsh', {'for': 'zsh'}
" Language-specific
" ~~~~~~~~~~~~~~~~~
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': [ 'pandoc', 'rst' ] }
Plug 'vim-pandoc/vim-pandoc-after', { 'for': [ 'pandoc', 'rst' ] }
" Plug 'numirias/semshi', { 'for': 'python' }  " Better python syntax highlighting.
Plug 'KeitaNakamura/tex-conceal.vim', {'for': ['plaintex', 'tex', 'pandoc']}
Plug 'nathanielc/vim-tickscript'

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
nnoremap <silent> <C-c><C-y> :call SwitchConcealLevel() <CR>
" Toggle invisible chars
nnoremap <leader>l :set list!<CR>

" keep text selected after indentation
vnoremap < <gv
vnoremap > >gv

" Buffer management
" ~~~~~~~~~~~~~~~~~

" Buffer switching
nnoremap gt :bnext<CR>
nnoremap gT :bprevious<CR>
nnoremap <tab> <C-w>l
nnoremap <s-tab> <C-w>h
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

" Use 24-bit (true-color) mode in Vim/Neovim
" (see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more.)
if has('nvim')
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if has('termguicolors')
	set termguicolors
endif
if has('transparency')
	set transparency=10
endif

if has('mac')
	let g:python_host_prog = '/usr/local/bin/python3'
else
	let g:python_host_prog = '/usr/bin/python3'
endif

" set cursorline  " Commented out because it slows (n)vim down.
if exists('&pumblend')
	set pumblend=15
endif

let g:one_allow_italics = 1

colorscheme breezy
hi Comment gui=italic
if !has('gui_running')
	" Use terminal emulator's background
	hi Normal guibg=NONE
endif
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
let g:rainbow_active = 1  " Rainbow brackets
let g:indentLine_char = "\uE621"  " dotted line  from powerline-patched-fonts
" Language-specific theme settings
let g:pymode_python = 'python3'  " Make sure python3 is used
let python_highlight_all = 1
let g:airline_theme = 'breezy'

" :terminal colors
" ~~~~~~~~~~~~~~~~

set t_ut=
" black
let g:terminal_color_0 = '#31363b'
let g:terminal_color_8 = '#6a6e71'

" red
let g:terminal_color_1 = '#ed1515'
let g:terminal_color_9 = '#c0392b'

" green
let g:terminal_color_2 = '#11d116'
let g:terminal_color_10 = '#1cdc9a'

" yellow
let g:terminal_color_3 = '#f67400'
let g:terminal_color_11 = '#fdbc4b'

" blue
let g:terminal_color_4 = '#1d99f3'
let g:terminal_color_12 = '#3daee9'

" magenta
let g:terminal_color_5 = '#9b59b6'
let g:terminal_color_13 = '#8e44ad'

" cyan
let g:terminal_color_6 = '#1abc9c'
let g:terminal_color_14 = '#16a085'

" white
let g:terminal_color_7 = '#eff0f1'
let g:terminal_color_15 = '#ffffff'

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

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current pos
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

" navigate git chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
" show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)
" show commit contains current position
nmap gC <Plug>(coc-git-commit)

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

function! s:OnTermOpen(buf)
	setl nolist norelativenumber nonumber
	if &buftype ==# 'terminal'
		nnoremap <buffer> q :<C-U>bd!<CR>
	endif
endfunction

augroup autocmds
	autocmd!
	" Update signature help on jump placeholder (useful for floating
	" window)
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
	autocmd TermOpen  *  :call s:OnTermOpen(+expand('<abuf>'))
augroup end

" Formatting
" ~~~~~~~~~~

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.orgnizeImport')

" Remove trailing whitespace, format and write
nmap <leader>w :%s/\s\+$//e<CR>:Format<CR>:w<CR>

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

" Open file found by ripgrep
nnoremap <silent> <space>/  :<C-u>CocList grep<cr>
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Extension marketplace
nnoremap <silent> <space>E  :<C-u>CocList marketplace<CR>
" vim commands
nnoremap <silent> <space>c  :<C-u>CocList vimcommands<cr>
" coc.nvim commands
nnoremap <silent> <space>C  :<C-u>CocList commands<cr>
" Show maps
nnoremap <silent> <space>m  :<C-u>CocList maps<CR>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" List snippets of current file
nnoremap <silent> <space>n  :<C-u>CocList <cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" ~~CocList Git~~
" Git status
nnoremap <silent> <space>gs :<C-u>CocList --normal gstatus<CR>
" Git branches
nnoremap <silent> <space>gb :<C-u>CocList branches<CR>
" Files on different branches/commits/tags
nnoremap <silent> <space>gf :<C-u>CocList gfiles<CR>
" Commits
nnoremap <silent> <space>gc :<C-u>CocList commits<CR>

" ~~CocList History~~
" Most recently used files
nnoremap <silent> <space>-r :<C-u>CocList mru<CR>
" Search history
nnoremap <silent> <space>-s :<C-u>CocList searchhistory<CR>
" Yank history
nnoremap <silent> <space>-y :<C-u>CocList yank<CR>
" Command history
nnoremap <silent> <space>-c :<C-u>CocList cmdhistory<CR>


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

" =======================
" Language-specific prefs
" =======================
" These are prefs that don't work well when run in autoload/ftplugin, so they
" go here.

let g:pandoc#after#modules#enabled = ["vim-table-mode"]
let g:pandoc#syntax#codeblocks#embeds#langs=["c", "python", "sh", "asm", "yaml", "html", "css", "vim", "go"]
let g:pandoc#formatting#mode = 'h'
let g:pandoc#modules#disabled = ["folding","formatting"]
let g:pandoc#syntax#conceal#cchar_overrides = {"codelang": ""}
let g:vimtex_compiler_progname = 'nvr'
