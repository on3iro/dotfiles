vim.opt_local.wrap = true
-- vim.opt_local.textwidth = 80
vim.opt_local.formatoptions:append('t')
vim.opt_local.sidescrolloff = 8

-- Keep manual indenting (>>, o, Tab, ==) in sync with prettier's 2-space list
-- indent (see conform-nvim.lua). Treesitter's indentexpr is skipped for
-- markdown in treesitter.lua because its list indent query is buggy.
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.expandtab = true
vim.opt_local.indentexpr = ""
vim.opt_local.autoindent = true
