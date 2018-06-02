" Vim-plug
"
call plug#begin('~/.vim/plugged')

"---------- Vim behavior/appearance --------------------------------

" [ COLORS ]
"
" Base 16 Colors
Plug 'chriskempson/base16-vim'

Plug 'hzchirs/vim-material'


" [ BEHAVIOR ]

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
" Prettier
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['css', 'sass', 'scss', 'json', 'graphql', 'markdown']}

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

"------------- Dev --------------------

" General language support
Plug 'sheerun/vim-polyglot'

" Plug 'ternjs/tern_for_vim'

" Autocompletion
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'carlitux/deoplete-ternjs', { 'do': 'sudo npm install -g tern'}

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
set termguicolors
" set t_Co=256
" let base16colorspace=256

" Color theme
colorscheme base16-monokai
" colorscheme vim-material
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
vnoremap <C-c> "+y

" Fugitive
set diffopt+=vertical

" Disable spell checker
set nospell

" Remove search highlight on esc
nnoremap <silent> <esc> :noh<cr><esc>


" [ COLORS/STATUS ]

""""" Status line """"""""""""
hi User1 guibg=DodgerBlue4 guifg=ivory1
hi User2 guibg=gray15 guifg=orange
hi User3 guibg=gray15 guifg=orange
hi User4 guibg=gray15 guifg=ivory3
hi User5 guibg=gray15 guifg=DeepSkyBlue2
hi User6 guibg=gray15 guifg=SteelBlue3
hi User7 guibg=gray15 guifg=gray40
hi User8 guibg=gray15 guifg=DeepSkyBlue2
hi User9 guibg=gray15 guifg=SteelBlue1
hi User10 guibg=gray15 guifg=178

" Change statusline in insert mode
function! EnterInsert()
    hi User1 guibg=IndianRed3
endfunction

function! LeaveInsert()
    hi User1 guibg=DodgerBlue4
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
" set statusline +=%8*%{fugitive#statusline()} " Git Hotness
"set statusline +=\ %P           "Percen through file
set statusline +=%9*\ \ %l       "curr line
set statusline +=%7*/
set statusline +=%6*%L         "total lines
set statusline +=%4*[%2*%c%4*]\          "current column
set statusline +=%8*[%4*%{strlen(&fenc)?&fenc:'none'}%8*] "file encoding"

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
let g:markdown_fenced_languages = ['html', 'python', 'bash=zsh']
let g:markdown_syntax_conceal = 0

" UltiSnips
" set runtimepath+=~/.vim
" let g:UltiSnipsSnippetsDir="~/.vim/mySnippets"
" let g:UltiSnipsSnippetsDirectories = ['UltiSnips', 'mySnippets']
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-a>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

" FZF
" Toggle fzf Files
nmap <leader>ne :Files<cr>
" Toggle fzf Buffers
nmap <leader>nb :Buffers<cr>
" Toggle fzf Ag
nmap <leader>na :Ag<cr>

""" zfz default command to include dot files
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -f -g ""'


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
let g:javascript_plugin_flow = 1

" elm
au BufNewFile,BufRead *.elm set
    \ tabstop=4
    \ softtabstop=4
    \ shiftwidth=4
    \ autoindent
    \ expandtab
let g:elm_format_autosave = 1

" vim-jsx
let g:jsx_ext_required = 1

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
let personal_wiki = {}
let personal_wiki.path = '~/vimwiki/'
let personal_wiki.syntax = 'markdown'
let personal_wiki.ext = '.md'

let sandstorm_wiki = {}
let sandstorm_wiki.path = '~/vw_sandstorm'
let sandstorm_wiki.syntax = 'markdown'
let sandstorm_wiki.ext = '.md'

let g:vimwiki_list = [personal_wiki, sandstorm_wiki]

nmap <leader>tt <Plug>VimwikiToggleListItem

""" Linters ale """
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_save = 1
let g:ale_set_highlights = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {
            \ 'javascript': ['standard', 'flow'],
            \}
let g:ale_fixers = {
            \ 'javascript': ['standard'],
            \}
nmap <silent> ]l <Plug>(ale_next_wrap)
nmap <silent> [l <Plug>(ale_previous_wrap)

""" Autocompletion
" Use deoplete.
let g:deoplete#enable_at_startup = 1
let g:deoplete#complete_method = "complete"

" Elixir alchemist
let g:alchemist_tag_disable = 1
