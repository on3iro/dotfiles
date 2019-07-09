" COC vim
" if hidden is not set, TextEdit might fail
set hidden

" Some servers have issues with backup files
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


" Add diagnostic info for https://github.com/itchyny/lightline.vim
" TODO evaluate if i would like to use lightline
" let g:lightline = {
      " \ 'colorscheme': 'wombat',
      " \ 'active': {
      " \   'left': [ [ 'mode', 'paste' ],
      " \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      " \ },
      " \ 'component_function': {
      " \   'cocstatus': 'coc#status'
      " \ },
      " \ }



" Using CocList
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
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" /end COC vim


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
            \ 'javascript': ['prettier'],
            \ 'typescript': ['prettier'],
            \}
nmap <silent> ]l <Plug>(ale_next_wrap)
nmap <silent> [l <Plug>(ale_previous_wrap)
