local a = vim.api

-- Remove search highlights until next search
a.nvim_set_keymap("n", "<esc>", ":noh <cr>", { noremap = false })

-- Also allow 'jk' to be used to go back to normal mode from insert mode
-- a.nvim_set_keymap("i", "jk", "<esc>", { noremap = true })

-- Move between windows
a.nvim_set_keymap("n", "<C-j>", "<C-w><C-j>", { noremap = false })
a.nvim_set_keymap("n", "<C-k>", "<C-w><C-k>", { noremap = false })
a.nvim_set_keymap("n", "<C-h>", "<C-w><C-h>", { noremap = false })
a.nvim_set_keymap("n", "<C-l>", "<C-w><C-l>", { noremap = false })

-- Create splits
a.nvim_set_keymap("n", "<C-s>", ":vs<cr>", { noremap = false })
a.nvim_set_keymap("n", "<C-x>", ":sp<cr>", { noremap = false })

-- Change pwd to current buffer
a.nvim_set_keymap("n", "<leader>cd", ":cd %:p:h<CR>", { noremap = true })

-- center cursor on up and down
a.nvim_set_keymap("n", "<C-u>", "<C-u>zz", { noremap = false })
a.nvim_set_keymap("n", "<C-d>", "<C-d>zz", { noremap = false })

vim.api.nvim_set_keymap("n", "]q", ":cnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[q", ":cprev<CR>", { noremap = true, silent = true })

-- Current iso date
vim.keymap.set("n", "<leader>dt", ":r !date -u +\\%Y-\\%m-\\%d<cr>")

-------------------------
-- [ Buffer settings ] --
-------------------------

-- vim.cmd("command! BufCurOnly execute '%bdelete|edit#|bdelete#'")

-- Close current buffer
-- a.nvim_set_keymap("n", "<leader>bd", ":bd<cr>", { noremap = false })

-- Close all but current buffer
-- a.nvim_set_keymap("n", "<leader>bo", ":BufCurOnly<cr>", { noremap = false })
