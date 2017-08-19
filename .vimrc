"TODO use vimplug instead of vundle
"
"
"
" Vundle
set nocompatible
filetype off                  " required


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" ------------- {{ PLUGINS }} --------------------------------------
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"---------- Vim behavior/appearance --------------------------------
" Base 16 Colors
Plugin 'chriskempson/base16-vim'

" NERDtree Browser
Plugin  'scrooloose/nerdtree'

" Vimtext
Plugin 'lervag/vimtex'

" Snippet engine
Plugin 'SirVer/ultisnips'
" Snippets
Plugin 'honza/vim-snippets'

" Bracket completion
Plugin 'Raimondi/delimitMate'

" repeat-vim
Plugin 'tpope/vim-repeat'

" Vim-Surround
Plugin 'tpope/vim-surround'

" Align code or tables
Plugin 'godlygeek/tabular'

" CSV capabilities
" Plugin 'chrisbra/csv.vim'

" Vimwiki
Plugin 'vimwiki/vimwiki'

Plugin 'mzlogin/vim-markdown-toc'

" Vim-easygrep
" Should be replaced by ack.vim
"Plugin 'rking/ag.vim'
Plugin 'mileszs/ack.vim'

"------------ Web related -------------
" JavaScript Tern
"Plugin 'ternjs/tern_for_vim'

" JS/HTML-Beautify
Plugin 'Chiel92/vim-autoformat'

" Close html tags
Plugin 'tpope/vim-ragtag'

" Emmet
Plugin 'mattn/emmet-vim'

" Css colors
Plugin 'ap/vim-css-color'

" Elm
" Plugin 'lambdatoast/elm.vim'
Plugin 'ElmCast/elm-vim'

" ------ JavaScript specific -----------
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'fleischie/vim-styled-components'
Plugin 'Quramy/vim-js-pretty-template'

"------------- Dev --------------------
" Git wrapper
Plugin 'tpope/vim-fugitive'

" Quick Commenting
Plugin 'scrooloose/nerdcommenter'

" Usefull keyboard functions for Glog
Plugin 'tpope/vim-unimpaired'

" Syntastic
Plugin 'scrooloose/syntastic'

" EditorConfig
Plugin 'editorconfig/editorconfig-vim'

" ------- Python specific --------------
" Python indent
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'jmcantrell/vim-virtualenv'

" ------- Haskell specific -------------
Plugin 'neovimhaskell/haskell-vim'

" -------------------------------------------------------------------

" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on

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

" Standard latex extension
let g:tex_flavor = "latex"

" Vimtex
let g:vimtex_latexmk_continuous = 1
let g:vimtex_view_method = 'zathura'

" Snippets
" let g:UltiSnipsSnippetsDir = ['~/UltiSnips']
" let g:UltiSnipsSnippetDirectories = ['~/UltiSnips', 'UltiSnips']
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-a>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

"Syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
let g:syntastic_check_on_open=0
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs=1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
" let g:syntastic_mode="passive"
let g:syntastic_javascript_checkers = ['standard']
let g:elm_syntastic_show_warnings = 1
let g:syntastic_elm_checkers = ['elm_make']
nnoremap <F7> :SyntasticCheck<CR> :lopen<CR>
nnoremap <F8> :SyntasticToggleMode<CR>

" Keyboard Settings
nmap <leader>ne :NERDTreeToggle<cr>

set encoding=utf-8

" gVim gui options
set guioptions-=m "remove menu bar
set guioptions-=T "remove tool bar
set guioptions-=L "remove left hand scroll bar"

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

" Disable conceal
let g:tex_conceal = ""

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

"""""" Tmux """""""""""""""""""
set term=xterm-256color

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
