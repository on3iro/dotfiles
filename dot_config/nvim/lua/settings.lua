local g = vim.g
local o = vim.opt
local a = vim.api
local c = vim.cmd

-- enable syntax highlighting
c("syntax on")

-- show line numbers
o.number = true
-- o.relativenumber = true

-- Leader key
g.mapleader = " "

-- Save more than 8 commands
o.history = 1000

-- set tabs to have 2 spaces
o.ts = 2

-- tabs to spaces
o.expandtab = true

-- autoindenting
o.autoindent = true

-- manual tab indent << or >>
o.shiftwidth = 2

-- visual line under current cursor line
o.cursorline = true

-- show matching braces
o.showmatch = true

-- enable project configuration
-- o.exrc = true

-- Use 256 colors
o.termguicolors = true

-- mark 80 character column
o.colorcolumn = "80"

-- Line Number BG
c("highlight LineNr guifg=gray35 guibg=NONE")

-- Search down into subfolders
-- Provides tab-completion for all file-related tasks
o.path = o.path + "**"

-- Display all matching files when we tab complete
o.wildmenu = true

-- All numbers are treated as decimal
o.nrformats = ""

-- Backspace fix
o.backspace = { "indent", "eol", "start" }

-- Always display status line
o.laststatus = 2

-- Faster escape
o.timeoutlen = 1000
o.ttimeoutlen = 0

-- No autoresizing on split windows
o.equalalways = false

o.wildignore = o.wildignore + "*/tmp/*,*.so,*.swp,*.exe,*.zip,**/vendor/**,**/node_modules/**"

-- Copy to clipboard
-- NOTE currently trying how it feels to explicitly use these registers
-- o.clipboard = "unnamedplus"

-- Disable spell checker
o.spell = false

-- Enable basic mouse support
o.mouse = "a"

-- Hide status message
o.showmode = false

-- Show special characters
o.lcs = {
  tab = ">-",
  trail = "·",
  extends = ">",
  precedes = "<",
}

--  r Automatically insert the current comment leader after hitting
--    <Enter> in Insert mode.
--  o Automatically insert the current comment leader after hitting 'o' or
--    'O' in Normal mode.
o.formatoptions = o.formatoptions + "ro"

-- trigger `autoread` when files changes on disk
o.autoread = true

-- Autocommand for FocusGained, BufEnter, CursorHold, CursorHoldI
a.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  callback = function()
    if vim.fn.mode() ~= "c" then
      c("checktime")
    end
  end,
})

-- Notification after file change
a.nvim_create_autocmd("FileChangedShellPost", {
  pattern = "*",
  callback = function()
    a.nvim_echo({ { "File changed on disk. Buffer reloaded.", "WarningMsg" } }, true, {})
  end,
})

-- Important, because somewhere lang isn't set to UTF8 and this causes Umlauts
-- to behave incorrect
o.encoding = "utf-8"
c("let $LANG='en_US.UTF-8'")

vim.api.nvim_create_autocmd({ "FileType" }, {
  desc = "Force commentstring to include spaces",
  -- group = ...,
  callback = function(event)
    local cs = vim.bo[event.buf].commentstring
    vim.bo[event.buf].commentstring = cs:gsub("(%S)%%s", "%1 %%s"):gsub("%%s(%S)", "%%s %1")
  end,
})

