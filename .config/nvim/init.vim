" Vim-plug
"
call plug#begin('~/.vim/plugged')

" ------------- {{ PLUGINS }} --------------------------------------
" let Vundle manage Vundle, required
Plug 'VundleVim/Vundle.vim'

"---------- Vim behavior/appearance --------------------------------
" Base 16 Colors
Plug 'chriskempson/base16-vim'

" NERDtree Browser
Plug  'scrooloose/nerdtree'

" Snippet engine
Plug 'SirVer/ultisnips'
" Snippets
Plug 'honza/vim-snippets'

" Bracket completion
Plug 'Raimondi/delimitMate'

" repeat-vim
Plug 'tpope/vim-repeat'

" Vim-Surround
Plug 'tpope/vim-surround'

" Vimwiki
Plug 'vimwiki/vimwiki'

Plug 'mzlogin/vim-markdown-toc'

" Vim-easygrep
Plug 'mileszs/ack.vim'

" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"------------ Web related -------------
" JS/HTML-Beautify
Plug 'Chiel92/vim-autoformat'

" Close html tags
Plug 'tpope/vim-ragtag'

" Emmet
Plug 'mattn/emmet-vim'

" Css colors
Plug 'ap/vim-css-color'

" Elm
" Plugin 'lambdatoast/elm.vim'
Plug 'ElmCast/elm-vim'

" ------ JavaScript specific -----------
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'fleischie/vim-styled-components'

"------------- Dev --------------------
" Linting
Plug 'w0rp/ale'

" Git wrapper
Plug 'tpope/vim-fugitive'

" Quick Commenting
Plug 'scrooloose/nerdcommenter'

" Usefull keyboard functions for Glog
Plug 'tpope/vim-unimpaired'

" EditorConfig
Plug 'editorconfig/editorconfig-vim'

" ------- Python specific --------------
" Python indent
Plug 'hynek/vim-python-pep8-indent'
Plug 'jmcantrell/vim-virtualenv'

" ------- Haskell specific -------------
Plug 'neovimhaskell/haskell-vim'

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
set relativenumber
set number

" Leader key
let mapleader = ","

" enable syntax highlighting
syntax enable

" Save more than 8 commands
set history=50

" set tabs to have 4 spaces
set ts=4

" tabs to spaces
set expandtab

" autoindenting
set autoindent

" manual tab indent << or >>
set shiftwidth=4

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
set t_Co=256
let base16colorspace=256

" Color theme
colorscheme base16-monokai
"colorscheme colorsbox-material

" Line Number BG
highlight LineNr ctermbg=black

" All numbers are treated as decimal
set nrformats=

" Backspace fix
set backspace=indent,eol,start

" Always display status line
set laststatus=2

" Faster escape
set timeoutlen=1000 ttimeoutlen=0

" Markdown support
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=zsh']
let g:markdown_syntax_conceal = 0

" Snippets
" set runtimepath+=~/.vim
" let g:UltiSnipsSnippetsDir="~/.vim/mySnippets"
" let g:UltiSnipsSnippetsDirectories = ['UltiSnips', 'mySnippets']
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-a>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

" Keyboard Settings
" Toggle fzf files
nmap <leader>ne :Files<cr>

set encoding=utf-8

" Freemarker syntax
au BufRead,BufNewFile *.vm set filetype=ftl

" closetag.vim config
let g:closetag_filenames = "*.html, *.xhtml, *.phtml, *.vm"

" Silver Searcher as default
" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" No autoresizing on split windows
set noea

set wildignore+=*/tmp/*,*.so,*.swp,*.exe,*.zip,**/vendor/**,**/node_modules/**

" Copy to clipboard
vnoremap <C-c> "+y

" Fugitive
set diffopt+=vertical

" Disable spell checker
set nospell

" Matchit vim for tag jumping
filetype detect
runtime macros/matchit.vim

" NERDtree settings
let NERDTreeIgnore = ['\.pyc$']

" NERDcommenter settings
let g:NERDSpaceDelims = 1
let g:NERDCustomDelimiters = {
            \ 'javascript': { 'left': '//', 'leftAlt': '/**','rightAlt': '*/' },
            \ 'javascript.jsx': { 'left': '//', 'leftAlt': '/**', 'rightAlt': '*/'}
            \ }

"""""" PYTHON """""""

au BufNewFile,BufRead *.py set
    \ tabstop=4
    \ softtabstop=4
    \ shiftwidth=4
    \ textwidth=79
    \ expandtab
    \ autoindent
    \ fileformat=unix

set encoding=utf-8

" enable python synthax highlighting
let python_highlight_all = 1

""""""" HTML / CSS / JavaScript """"""""""
au BufNewFile,BufRead *.js,*.html,*.scss set
    \ tabstop=2
    \ softtabstop=2
    \ shiftwidth=2
    \ autoindent
    \ expandtab
let g:javascript_plugin_jsdoc = 1

" elm
au BufNewFile,BufRead *.elm set
    \ tabstop=4
    \ softtabstop=4
    \ shiftwidth=4
    \ autoindent
    \ expandtab
let g:elm_format_autosave = 1

" vim-jsx
let g:jsx_ext_required = 0

" JSON
au BufNewFile,BufRead *.json set ft=json

"""""""" Haskell """""""""""""
au BufNewFile,BufRead *.hs set
    \ tabstop=2
    \ softtabstop=2
    \ shiftwidth=2
    \ autoindent
    \ expandtab

""""" Vimwiki """""""""""""""""
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

""""" Status line """"""""""""
hi User1 ctermbg=24 ctermfg=254
hi User2 ctermfg=117
hi User3 ctermfg=178
hi User4 ctermfg=38
hi User5 ctermfg=252
hi User6 ctermfg=red
hi User7 ctermfg=white
hi User8 ctermfg=green
hi User9 ctermbg=black
hi User10 ctermfg=178

" Change statusline in insert mode
function! EnterInsert()
    hi User1 ctermbg=88
    hi User5 ctermbg=24
    hi User3 ctermbg=24
endfunction

function! LeaveInsert()
    hi User1 ctermbg=24
    hi User5 ctermbg=black
    hi User3 ctermbg=black
endfunction

au InsertEnter * call EnterInsert()
au InsertLeave * call LeaveInsert()

" Mode aliases
let g:currentmode={
    \ 'n'  : 'Normal',
    \ 'no' : 'N·Operator Pending',
    \ 'v'  : 'Visual',
    \ 'V'  : 'V Line',
    \ '' : 'V Block',
    \ 's'  : 'Select',
    \ 'S'  : 'S·Line',
    \ '' : 'S·Block',
    \ 'i'  : 'Insert',
    \ 'R'  : 'R',
    \ 'Rv' : 'V·Replace',
    \ 'c'  : 'Command',
    \ 'cv' : 'Vim Ex',
    \ 'ce' : 'Ex',
    \ 'r'  : 'Prompt',
    \ 'rm' : 'More',
    \ 'r?' : 'Confirm',
    \ '!'  : 'Shell',
    \ 't'  : 'Terminal'
    \}

" Show paste indicator
function! ShowPaste()
    if &paste
        return "  (Paste)"
    else
        return ""
    endif
endfunction

set statusline=                 "Clear status line for when vimrc is reloaded
set statusline +=%1*\ B%n\,\ %{g:currentmode[mode()]}%{ShowPaste()}\ %*    "buffer number
set statusline +=%5*\ %{&ff}%*    "file format
set statusline +=%3*%y%*         "file type
set statusline +=%4*\ %<%F%*     "full path
set statusline +=%6*%r             "Readonly flag
set statusline +=%2*%m%*        "modified flag
set statusline +=%9*%=             " left/right separator
set statusline +=%8*%{fugitive#statusline()} " Git Hotness
"set statusline +=\ %P           "Percen through file
set statusline +=%9*\ \ %l       "curr line
set statusline +=%7*/
set statusline +=%6*%L         "total lines
set statusline +=%4*[%2*%c%4*]\          "current column
set statusline +=%8*[%4*%{strlen(&fenc)?&fenc:'none'}%8*] "file encoding"

" Hide status message
set noshowmode

"""" Other highlights """"
hi jsonStringSQError ctermfg=red
hi jsonNoQuotesError ctermfg=red
hi jsonTripleQuotesError ctermfg=red

"""" Show special characters """"
set list lcs=tab:>-,trail:·,extends:>,precedes:<

""" Linters ale """
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_save = 1
let g:ale_linters = {
            \ 'javascript': ['standard'],
            \}

""" zfz default command to include dot files
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -f -g ""'
