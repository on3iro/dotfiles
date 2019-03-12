" NERDcommenter settings
let g:NERDSpaceDelims = 1
let g:NERDCustomDelimiters = {
            \ 'javascript': { 'left': '//', 'leftAlt': '/**','rightAlt': '*/' },
            \ 'javascript.jsx': { 'left': '//', 'leftAlt': '/**', 'rightAlt': '*/'},
            \ 'typescript': { 'left': '//', 'leftAlt': '/**','rightAlt': '*/' },
            \ 'typescript.tsx': { 'left': '//', 'leftAlt': '/**', 'rightAlt': '*/'}
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

" typescript
au BufNewFile,BufRead *.ts,*.tsx set
    \ tabstop=2
    \ softtabstop=2
    \ shiftwidth=2
    \ autoindent
    \ expandtab

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

""" Linters ale """
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_save = 1
let g:ale_set_highlights = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {
            \ 'javascript': ['standard'],
            \}
let g:ale_linters = {
            \ 'typescript': ['tsserver'],
            \}
let g:ale_fixers = {
            \ 'javascript': ['standard'],
            \}
nmap <silent> ]l <Plug>(ale_next_wrap)
nmap <silent> [l <Plug>(ale_previous_wrap)

" Elixir alchemist
" let g:alchemist_tag_disable = 1

