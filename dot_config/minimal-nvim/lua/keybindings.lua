local a = vim.api

-- Remove search highlights until next search
a.nvim_set_keymap("n", "<esc>", ":noh <cr>", { noremap = true })

-- Move between windows
a.nvim_set_keymap("n", "<C-j>", "<C-w><C-j>", { noremap = false })
a.nvim_set_keymap("n", "<C-k>", "<C-w><C-k>", { noremap = false })
a.nvim_set_keymap("n", "<C-h>", "<C-w><C-h>", { noremap = false })
a.nvim_set_keymap("n", "<C-l>", "<C-w><C-l>", { noremap = false })

-- Change pwd to current buffer
a.nvim_set_keymap("n", "<leader>cd", ":cd %:p:h<CR>", { noremap = true })

-- center cursor on up and down
a.nvim_set_keymap("n", "<C-u>", "<C-u>zz", { noremap = false })
a.nvim_set_keymap("n", "<C-d>", "<C-d>zz", { noremap = false })

-------------------------
-- [ Buffer settings ] --
-------------------------

vim.cmd("command! BufCurOnly execute '%bdelete|edit#|bdelete#'")

-- Close current buffer
a.nvim_set_keymap("n", "<leader>bd", ":bd<cr>", { noremap = false })

-- Close all but current buffer
a.nvim_set_keymap("n", "<leader>bo", ":BufCurOnly<cr>", { noremap = false })
