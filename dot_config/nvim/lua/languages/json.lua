local c = vim.cmd

c("hi jsonStringSQError guifg=red2")
c("hi jsonNoQuotesError guifg=red2")
c("hi jsonTripleQuotesError guifg=red2")
c("au BufNewFile,BufRead *.json set ft=json")
