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

