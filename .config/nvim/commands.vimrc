" Open shellcommand with output in new buffer
" This command is useful for shell commands that produce helpful output
" new -> new file
" 0read -> takes this file and pipes in output of !bashcommand
command! -nargs=+ OneiroFromShell new | 0read !<args>
