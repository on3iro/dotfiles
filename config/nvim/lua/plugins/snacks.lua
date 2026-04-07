require("snacks").setup({
  bigfile = { enabled = true },
  indent = { enabled = true },
  input = { enabled = true },
  quickfile = { enabled = true },
  words = { enabled = true },
  statuscolumn = {
    enabled = true,
    left = { "mark", "sign" },
    right = { "fold", "git" },
    folds = {
      open = true,
      git_hl = false,
    },
    git = {
      patterns = { "GitSign", "MiniDiffSign" },
    },
    refresh = 50,
  },
  toggle = {
    enabled = true,
    map = vim.keymap.set,
    which_key = true,
    notify = false,
    icon = {
      enabled = " ",
      disabled = " ",
    },
    color = {
      enabled = "green",
      disabled = "yellow",
    },
    wk_desc = {
      enabled = "Disable ",
      disabled = "Enable ",
    },
  },
  picker = {
    enabled = false,
    prompt = " ",
    sources = {},
    focus = "input",
    layout = {
      cycle = true,
      preset = "ivy",
      layout = { position = "bottom" }
    },
    formatters = {
      file = {
        filename_first = true,
        truncate = 240
      }
    },
    ui_select = true,
    win = {
      input = {
        keys = {
          ["<c-t>"] = { "toggle_live", mode = { "i", "n" } },
          ["<c-h>"] = { "toggle_hidden", mode = { "i", "n" } },
          ["<c-i>"] = { "toggle_ignored", mode = { "i", "n" } },
          ["<c-p>"] = { "toggle_preview", mode = { "i", "n" } },
          ["<c-r>"] = { "toggle_regex", mode = { "i", "n" } },
          ["<s-k>"] = { "inspect", mode = { "i", "n" } },
        },
      },
    },
  },
  zen = {
    toggles = {
      dim = true,
      git_signs = false,
      mini_diff_signs = false,
    },
    show = {
      statusline = false,
      tabline = false,
    },
    win = { style = "zen" },
    on_open = function(win) end,
    on_close = function(win) end,
    zoom = {
      toggles = {
        dim = true,
      },
      show = { statusline = true, tabline = true },
      win = {
        backdrop = false,
        width = 0,
      },
    },
  },
  styles = {}
})

-- Scratch buffers
vim.keymap.set("n", "<leader>.", function() Snacks.scratch.open() end, { desc = "Toggle Scratch Buffer" })
vim.keymap.set("n", "<leader>S", function() Snacks.scratch.select() end, { desc = "Select Scratch Buffer" })

-- Zen
vim.keymap.set("n", "<leader>zen", function() Snacks.zen() end, { desc = "Zen Mode" })
vim.keymap.set("n", "<leader>+", function() Snacks.zen.zoom() end, { desc = "Zen Zoom" })

-- Todo/Fixme/Note comments
vim.keymap.set("n", "<leader>td", function() Snacks.picker.todo_comments() end, { desc = "Todo" })

-- Files
vim.keymap.set("n", "<leader>f", function() Snacks.picker.files() end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>sm", function() Snacks.picker.smart() end, { desc = "Find Files Smart" })
vim.keymap.set("n", "<leader>bu", function() Snacks.picker.buffers() end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>hi", function() Snacks.picker.recent() end, { desc = "Recent" })
vim.keymap.set("n", "<leader>zo", function() Snacks.picker.zoxide() end, { desc = "Zoxide" })

-- Grep
vim.keymap.set({ "n", "x" }, "<leader>gw", function() Snacks.picker.grep_word() end, { desc = "Visual selection or word" })
vim.keymap.set("n", "<leader>/", function() Snacks.picker.grep() end, { desc = "Grep" })
vim.keymap.set("n", "<leader>l", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })

-- Git
vim.keymap.set("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "Git Log" })
vim.keymap.set("n", "<leader>glf", function() Snacks.picker.git_log_file() end, { desc = "Git Log File" })
vim.keymap.set("n", "<leader>gll", function() Snacks.picker.git_log_line() end, { desc = "Git Log Line" })
vim.keymap.set("n", "<leader>gb", function() Snacks.picker.git_branches() end, { desc = "Git Branches" })
vim.keymap.set("n", "<leader>gg", function() Snacks.picker.git_grep() end, { desc = "Git Grep" })
vim.keymap.set("n", "<leader>gf", function() Snacks.picker.git_grep() end, { desc = "Git Files" })
vim.keymap.set("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git Status" })

-- Search
vim.keymap.set("n", "<leader>he", function() Snacks.picker.help() end, { desc = "Nvim Help" })
vim.keymap.set("n", "<leader>di", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>dib", function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
vim.keymap.set("n", "<leader>key", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>col", function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" })

-- LSP
vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
vim.keymap.set("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declarations" })
vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, { desc = "Goto References" })
vim.keymap.set("n", "gi", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
vim.keymap.set("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto T[y]pe Definitions" })
vim.keymap.set("n", "<leader>si", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" })

-- Notes
vim.keymap.set("n", "<leader>n/", function()
  Snacks.picker.grep({ dirs = { "~/notes" }, follow = true })
end, { desc = "Grep Notes" })
vim.keymap.set("n", "<leader>nf", function()
  Snacks.picker.files({ dirs = { "~/notes" }, follow = true })
end, { desc = "Find Notes" })
