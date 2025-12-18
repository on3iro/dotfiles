local c = vim.cmd
local a = vim.api

c("autocmd BufNewFile,BufReadPost *.md set filetype=markdown")

-- Notes
-- TODO see if there is a lua way to write these
c("command! Note edit `touty -t ~/Nextcloud/Notes/scratchpad -n note`")
c("command! NoteYesterday edit `touty -t ~/Nextcloud/Notes/scratchpad -n note -a -1d`")
c("command! NoteTomorrow edit `touty -t ~/Nextcloud/Notes/scratchpad -n note -a +1d`")
c("command! Diary edit `touty -t ~/Nextcloud/Notes/diary -n diary`")

a.nvim_set_keymap("n", "<leader>no", ":Note<CR>", { noremap = true })
a.nvim_set_keymap("n", "<leader>mo", ":NoteTomorrow<CR>", { noremap = true })

-- tmp files
c("command! TmpFile edit ~/tmp-theo/scratchpad")
a.nvim_set_keymap("n", "<leader>tm", ":TmpFile<CR>", { noremap = true })
