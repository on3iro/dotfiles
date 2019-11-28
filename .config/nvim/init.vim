" Vim-plug
"
call plug#begin('~/.vim/plugged')

"---------- Vim behavior/appearance --------------------------------
Plug 'Shougo/vimproc.vim', {'do' : 'make'}

" [ COLORS ]
"
" Base 16 Colors
Plug 'chriskempson/base16-vim'
Plug 'hzchirs/vim-material'
Plug 'flrnprz/plastic.vim'

" Plug 'on3iro/vim-neos-fusion-syntax'
Plug '~/src/theo/fusion-syntax/'

" [ BEHAVIOR ]

" NERDtree Browser
Plug  'scrooloose/nerdtree'

" Bracket completion
Plug 'Raimondi/delimitMate'

" repeat-vim
Plug 'tpope/vim-repeat'

" Vim-Surround
Plug 'tpope/vim-surround'

" Vim-easygrep
Plug 'mileszs/ack.vim'

" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" [ MARKDOWN ]

" Vimwiki
Plug 'vimwiki/vimwiki'

" Table of contents
Plug 'mzlogin/vim-markdown-toc'

" Markdown Table formatting
Plug 'godlygeek/tabular'

" Instant markdown preview
Plug 'suan/vim-instant-markdown', {
  \ 'for': 'markdown'}

"------------ Web related -------------
" JS/HTML-Beautify
Plug 'Chiel92/vim-autoformat'
" Prettier
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['js', 'jsx', 'ts', 'tsx', 'css', 'sass', 'scss', 'json', 'graphql', 'markdown']}

" Close html tags
Plug 'tpope/vim-ragtag'

" Emmet
Plug 'mattn/emmet-vim'

" Css colors
Plug 'ap/vim-css-color'

" ----- Elm -----
" Plugin 'lambdatoast/elm.vim'
Plug 'ElmCast/elm-vim'

" ----- Elixir --
Plug 'slashmili/alchemist.vim'

" ------ JavaScript specific -----------
Plug 'fleischie/vim-styled-components'

" ------ TypeScript -----------------
Plug 'ianks/vim-tsx'
" Plug 'Quramy/tsuquyomi'

"------------- Dev --------------------

" General language support
Plug 'sheerun/vim-polyglot'

" Autocompletion
" COC vim
" Use release branch
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Or latest tag
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
" Or build from source code by use yarn: https://yarnpkg.com
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

" Snippets
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

" Linting
" Plug 'w0rp/ale'

" Git wrapper
Plug 'tpope/vim-fugitive'

" Quick Commenting
Plug 'scrooloose/nerdcommenter'

" Usefull keyboard functions for Glog
Plug 'tpope/vim-unimpaired'

" EditorConfig
Plug 'editorconfig/editorconfig-vim'

" ------- Python specific --------------
Plug 'jmcantrell/vim-virtualenv'

" -------------------------------------------------------------------

call plug#end()
filetype plugin indent on
" End vim-plug """""

" Resize window with arrow keys
nnoremap <Left> :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>
nnoremap <Up> :resize -2<CR>
nnoremap <Down> :resize +2<CR>

" Move between windows
nmap <C-j> <C-w><C-j>
nmap <C-k> <C-w><C-k>
nmap <C-h> <C-w><C-h>
nmap <C-l> <C-w><C-l>

" show line numbers
" set relativenumber
set number

" Leader key
let mapleader = ","

" enable syntax highlighting
syntax enable

" Save more than 8 commands
set history=1000

" set tabs to have 4 spaces
set ts=2

" tabs to spaces
set expandtab

" autoindenting
set autoindent

" manual tab indent << or >>
set shiftwidth=2

" visual line under current cursor line
set cursorline

" show matching braces
set showmatch

" mark 80 character column
set colorcolumn=80

" warn if there is trailing whitespace
match ErrorMsg '\s\+$'

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu

" switch to paste mode via F2
set pastetoggle=<F2>

"Use 256 colors
set termguicolors

" Color theme
" colorscheme base16-monokai
colorscheme base16-gruvbox-dark-hard
" colorscheme base16-bespin
" colorscheme vim-material
" set background=dark
" colorscheme plastic
" let g:lightline = {'colorscheme': 'plastic'}

"colorscheme colorsbox-material

" Line Number BG
highlight LineNr guifg=gray35 guibg=NONE

" All numbers are treated as decimal
set nrformats=

" Backspace fix
set backspace=indent,eol,start

" Always display status line
set laststatus=2

" Faster escape
set timeoutlen=1000 ttimeoutlen=0

" No autoresizing on split windows
set noea

set wildignore+=*/tmp/*,*.so,*.swp,*.exe,*.zip,**/vendor/**,**/node_modules/**

" Copy to clipboard
set clipboard=unnamedplus
vnoremap <C-c> "+y

" Fugitive
set diffopt+=vertical

" Disable spell checker
set nospell

" Enable basic mouse support
set mouse=a

" Remove search highlight on esc
nnoremap <silent> <esc> :noh<cr><esc>


" [ VISUAL ]

" Hide status message
set noshowmode

"""" Other highlights """"
hi jsonStringSQError guifg=red2
hi jsonNoQuotesError guifg=red2
hi jsonTripleQuotesError guifg=red2

"""" Show special characters """"
set list lcs=tab:>-,trail:·,extends:>,precedes:<


" [ PLUGIN RELATED ]

" Markdown support
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['html=html', 'python=py', 'bash=zsh', 'javascript=js', 'java=java']
let g:markdown_syntax_conceal = 0
au FileType markdown setl conceallevel=0

" Mardown preview
" "Uncomment to override defaults:
let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 0
"let g:instant_markdown_open_to_the_world = 1 
"let g:instant_markdown_allow_unsafe_content = 1
"let g:instant_markdown_allow_external_content = 0
"let g:instant_markdown_mathjax = 1

" FZF
" Toggle fzf Files
nmap <leader>ne :Files<cr>
" Toggle fzf Buffers
nmap <leader>nb :Buffers<cr>
" Toggle fzf Ag
nmap <leader>na :Ag<cr>
nmap <leader>nl :BLines<cr>
nmap <leader>nh :History<cr>

" NerdTree
nmap <leader>nt :NERDTreeToggle<cr>
nmap <leader>nf :NERDTreeFind<cr>

set encoding=utf-8

" closetag.vim config
let g:closetag_filenames = "*.html, *.xhtml, *.phtml, *.vm"

""" zfz default command to include dot files
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -f -g ""'

" Silver Searcher as default
" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" Matchit vim for tag jumping
filetype detect
runtime macros/matchit.vim

" NERDtree settings
let NERDTreeIgnore = ['\.pyc$']

""" Autocompletion

""" VIMRC Imports
source $HOME/.config/nvim/status.vimrc
source $HOME/.config/nvim/vimwiki.vimrc
source $HOME/.config/nvim/languages.vimrc
source $HOME/.config/nvim/commands.vimrc

""" Snippets """
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
" if has('conceal')
  " set conceallevel=2 concealcursor=niv
" endif

let g:neosnippet#snippets_directory = '~/.vim/snippets'

" Important, because somewhere lang isn't set to UTF8 and this causes Umlauts
" to behave incorrect
let $LANG='en_US.UTF-8'
