local ss = require("smart-splits")

vim.keymap.set("n", "<c-h>", ss.move_cursor_left, { silent = true, desc = "navigate left" })
vim.keymap.set("n", "<c-j>", ss.move_cursor_down, { silent = true, desc = "navigate down" })
vim.keymap.set("n", "<c-k>", ss.move_cursor_up, { silent = true, desc = "navigate up" })
vim.keymap.set("n", "<c-l>", ss.move_cursor_right, { silent = true, desc = "navigate right" })
