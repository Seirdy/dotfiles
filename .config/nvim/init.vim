" General Settings
" ================

filetype plugin on
set title
set updatetime=300
set backspace=indent,eol,start
set ignorecase                     " Case-insensitive search
set smartcase
set wildmenu
set wildmode=longest:full,full
set wildoptions+=pum
set mouse=a
set lazyredraw
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
set splitright " open vnew windows to the right

"" Default formatting when not detected
set smartindent
set shiftwidth=2
set tabstop=2  " Anything more than that is distracting.
" I like splitting windows side-by-side.
" On a laptop screen, my terminal often has 92 columns.
" 92 cols - 2 sign cols - 3 number cols
" - 1 padding col = 86 cols
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
Plug 'tpope/vim-endwise' " auto-add 'endif', 'end', 'endfunction', etc.
Plug 'townk/vim-autoclose'  " Auto-match pairs in insert mode
Plug 'tpope/vim-commentary'  " Polygot keybinds for commenting code
Plug 'dhruvasagar/vim-table-mode', {'for': ['rst', 'pandoc']}  " Build ascii tables
Plug 'ConradIrwin/vim-bracketed-paste'  " Auto-sets paste

" More powerful/sophisticated plugins
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Plug 'rhysd/git-messenger.vim' " git info in a floating window
Plug 'mhinz/vim-signify' " display VCS diff in signcolumn and navigate VCS chunks
Plug 'neovim/nvim-lsp' " The most important plugin

" FZF
" ~~~
Plug '/home/rkumar/Executables/go/src/github.com/junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Appearance Plugins
" ~~~~~~~~~~~~~~~~~~
Plug 'ryanoasis/vim-devicons'  " File icons: works with vim-ariline.
Plug 'vim-airline/vim-airline'  " Like powerline
Plug 'fneu/breezy'  " Exactly like breeze theme for ktexteditor
Plug 'norcalli/nvim-colorizer.lua' " Fastest color-code colorizer

" Syntax highlighting
" ~~~~~~~~~~~~~~~~~
Plug 'KeitaNakamura/tex-conceal.vim', {'for': ['plaintex', 'tex', 'pandoc']}
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': [ 'pandoc', 'rst' ] }
Plug 'vim-pandoc/vim-pandoc-after', { 'for': [ 'pandoc', 'rst' ] }
Plug 'cespare/vim-toml'
Plug 'zinit-zsh/zinit-vim-syntax', { 'for': 'zsh' }
Plug 'mboughaba/i3config.vim', { 'for': 'i3config' }

call plug#end()

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

let g:python_host_prog = '/usr/bin/python3'

" set cursorline  " Commented out because it slows (n)vim down.
if exists('&pumblend')
	set pumblend=15
	set winblend=10
	hi PmenuSel blend=10
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
let g:airline_extensions = ['branch', 'tabline']
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
" let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
" let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
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

" nvim-lsp

lua << EOF
require('lsp')
EOF

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

" ============
" Gen. Keymaps
" ============

" Keymaps for coc features are in a dedicated section.

" 'Ex mode is fucking dumb' --sircmpwm
nnoremap Q <Nop>

let mapleader = ','  " better than backslash imo
" hide search
nmap <silent> <leader><Space> :nohls<CR>
" If hiding search wasn't enough for you
nnoremap <silent> <C-l> :nohl<CR> :redraw<CR>
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
nnoremap <silent> <space>b :<C-u>Buffers<cr>

" Formatting
" ~~~~~~~~~~

" Use `:Format` for format current buffer
command! -nargs=0 StripTrailingSpaces :%s/\s\+$//e
" gets overridden in some filtypes
command! -nargs=0 Format :StripTrailingSpaces
" " Remove trailing whitespace, format and write
nmap <leader>w :Format<CR>:w<CR>

" Obsolete CoC.nvim configs that I have yet to replace
" ====================================================

" " Navigation
" " ~~~~~~~~~~

" " Use `[c` and `]c` for navigate diagnostics
" nmap <silent> [c <Plug>(coc-diagnostic-prev)
" nmap <silent> ]c <Plug>(coc-diagnostic-next)

" " show chunk diff at current position
" nmap gs <Plug>(coc-git-chunkinfo)

" " codeAction
" " ~~~~~~~~~~

" " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
" vmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" " Remap for do codeAction of current line
" nmap <leader>ac  <Plug>(coc-codeaction)

" " use `:OR` for organize import of current buffer
" command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.orgnizeImport')

" " Other
" " ~~~~~

" " Use `:Fold` for fold current buffer
" command! -nargs=? Fold :call CocAction('fold', <f-args>)

" " Fix autofix problem of current line
" nmap <leader>qf  <Plug>(coc-fix-current)

" " don't give |ins-completion-menu| messages.
" " set shortmess+=c

" " Coc Snippets
" " ~~~~~~~~~~~~

" " Use <C-l> for trigger snippet expand.
" imap <C-l> <Plug>(coc-snippets-expand)

" " Use <C-j> for select text for visual placeholder of snippet.
" vmap <C-j> <Plug>(coc-snippets-select)

" " Use <C-j> for jump to next placeholder, it's default of coc.nvim
" let g:coc_snippet_next = '<c-j>'

" " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
" let g:coc_snippet_prev = '<c-k>'

" " Use <C-j> for both expand and jump (make expand higher priority.)
" imap <C-j> <Plug>(coc-snippets-expand-jump)

" fzf.vim
" ~~~~~~~

" Fuzzy ripgrep
nnoremap <silent> <space>/  <cmd>Rg<cr>
" " Show all diagnostics
" nnoremap <silent> <space>a  <cmd>CocList diagnostics<cr>
" vim commands
nnoremap <silent> <space>c  <cmd>Commands<cr>
" Show maps
nnoremap <silent> <space>m  <cmd>Maps<CR>
" Find symbol of current document
nnoremap <silent> <space>o  <cmd>BTags<cr>
" Search workspace symbols
nnoremap <silent> <space>s  <cmd>Tags<cr>
" List files
nnoremap <silent> <space>f  <cmd>Files<cr>
" List buffers
nnoremap <silent> <space>b  <cmd>Buffers<cr>
" Help
nnoremap <silent> <space>h  <cmd>Helptags<cr>

" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>

" " ~~CocList Git~~
" " Git status
" nnoremap <silent> <space>gs :<C-u>CocList --normal gstatus<CR>
" " Git branches
" nnoremap <silent> <space>gb :<C-u>CocList branches<CR>
" " Files on different branches/commits/tags
" nnoremap <silent> <space>gf :<C-u>CocList gfiles<CR>
" " Commits
" nnoremap <silent> <space>gc :<C-u>CocList commits<CR>

" " ~~CocList History~~
" " Most recently used files
" nnoremap <silent> <space>-r :<C-u>CocList mru<CR>
" " Search history
" nnoremap <silent> <space>-s :<C-u>CocList searchhistory<CR>
" " Yank history
" nnoremap <silent> <space>-y :<C-u>CocList yank<CR>
" " Command history
" nnoremap <silent> <space>-c :<C-u>CocList cmdhistory<CR>

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
let g:pandoc#syntax#codeblocks#embeds#langs=["c", "cpp", "python", "sh", "asm", "yaml", "html", "css", "vim", "go", "haskell", "scheme", "prolog", "ruby", "javascript", "zsh", "ocaml", "rust"]
let g:pandoc#formatting#mode = 'h'
let g:pandoc#modules#disabled = ["folding","formatting"]
let g:pandoc#syntax#conceal#cchar_overrides = {"codelang": ""}
let g:vimtex_compiler_progname = 'nvr'
