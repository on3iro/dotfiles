return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true, prompt_pos = "left" },
    quickfile = { enabled = true },
    words = { enabled = true },
    statuscolumn = {
      enabled = true,
      left = { "mark", "sign" }, -- priority of signs on the left (high to low)
      right = { "fold", "git" }, -- priority of signs on the right (high to low)
      folds = {
        open = true,             -- show open fold icons
        git_hl = false,          -- use Git Signs hl for fold icons
      },
      git = {
        -- patterns to match Git signs
        patterns = { "GitSign", "MiniDiffSign" },
      },
      refresh = 50, -- refresh at most every 50ms
    },
    toggle = {
      enabled = true,
      map = vim.keymap.set, -- keymap.set function to use
      which_key = true,     -- integrate with which-key to show enabled/disabled icons and colors
      notify = false,       -- show a notification when toggling
      -- icons for enabled/disabled states
      icon = {
        enabled = " ",
        disabled = " ",
      },
      -- colors for enabled/disabled states
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
      prompt = " ",
      sources = {},
      focus = "input",
      layout = {
        cycle = true,
        --- Use the default layout or vertical if the window is too narrow
        preset = "ivy",
        layout = { position = "bottom" }
      },
      formatters = {
        file = {
          filename_first = true,
          truncate = 240
        }
      },
      ui_select = true, -- replace `vim.ui.select` with the snacks picker
      win = {
        input = {
          keys = {
            ["<c-t>"] = { "toggle_live", mode = { "i", "n" } },
            ["<c-h>"] = { "toggle_hidden", mode = { "i", "n" } },
            ["<c-i>"] = { "toggle_ignored", mode = { "i", "n" } },
            ["<c-p>"] = { "toggle_preview", mode = { "i", "n" } },
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
        -- diagnostics = false,
        -- inlay_hints = false,
      },
      show = {
        statusline = false, -- can only be shown when using the global statusline
        tabline = false,
      },
      ---@type snacks.win.Config
      win = { style = "zen" },
      --- Callback when the window is opened.
      ---@param win snacks.win
      on_open = function(win) end,
      --- Callback when the window is closed.
      ---@param win snacks.win
      on_close = function(win) end,
      --- Options for the `Snacks.zen.zoom()`
      ---@type snacks.zen.Config
      zoom = {
        toggles = {
          dim = true,
        },
        show = { statusline = true, tabline = true },
        win = {
          backdrop = false,
          width = 0, -- full width
        },
      },
    },
    styles = {}
  },
  keys = {
    -- Scratch buffers
    { "<leader>.",   function() end,                                       desc = "Toggle Scratch Buffer" },
    { "<leader>S",   function() Snacks.scratch.select() end,               desc = "Select Scratch Buffer" },

    -- Zen
    { "<leader>zen", function() Snacks.zen() end,                          desc = "Zen Mode" },
    { "<leader>+",   function() Snacks.zen.zoom() end,                     desc = "Zen Zoom" },

    ------------
    -- Picker --
    ------------

    -- Todo/Fixme/Note comments
    { "<leader>td",  function() Snacks.picker.todo_comments() end,         desc = "Todo" },
    -- Files
    { "<leader>f",   function() Snacks.picker.files() end,                 desc = "Find Files" },
    { "<leader>sm",  function() Snacks.picker.smart() end,                 desc = "Find Files Smart" },
    { "<leader>bu",  function() Snacks.picker.buffers() end,               desc = "Buffers" },
    { "<leader>hi",  function() Snacks.picker.recent() end,                desc = "Recent" },
    { "<leader>zo",  function() Snacks.picker.zoxide() end,                desc = "Zoxide" },
    -- Grep
    { "<leader>gw",  function() Snacks.picker.grep_word() end,             desc = "Visual selection or word", mode = { "n", "x" } },
    { "<leader>/",   function() Snacks.picker.grep() end,                  desc = "Grep" },
    { "<leader>l",   function() Snacks.picker.lines() end,                 desc = "Buffer Lines" },
    -- Git
    { "<leader>gc",  function() Snacks.picker.git_log() end,               desc = "Git Log" },
    { "<leader>gb",  function() Snacks.picker.git_branches() end,          desc = "Git Branches" },
    { "<leader>gs",  function() Snacks.picker.git_status() end,            desc = "Git Status" },
    -- Search
    { "<leader>he",  function() Snacks.picker.help() end,                  desc = "Nvim Help" },
    { "<leader>di",  function() Snacks.picker.diagnostics() end,           desc = "Diagnostics" },
    { "<leader>dib", function() Snacks.picker.diagnostics_buffer() end,    desc = "Buffer Diagnostics" },
    { "<leader>key", function() Snacks.picker.keymaps() end,               desc = "Keymaps" },
    { "<leader>col", function() Snacks.picker.colorschemes() end,          desc = "Colorschemes" },
    -- Lsp
    { "gd",          function() Snacks.picker.lsp_definitions() end,       desc = "Goto Definition" },
    { "gD",          function() Snacks.picker.lsp_declarations() end,      desc = "Goto Declarations" },
    { "gr",          function() Snacks.picker.lsp_references() end,        desc = "Goto References" },
    { "gi",          function() Snacks.picker.lsp_implementations() end,   desc = "Goto Implementation" },
    { "gy",          function() Snacks.picker.lsp_type_definitions() end,  desc = "Goto T[y]pe Definitions" },
    { "<leader>si",  function() Snacks.picker.lsp_symbols() end,           desc = "LSP Symbols" },
    { "<leader>ws",  function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
    -- Notes
    {
      "<leader>n/",
      function()
        Snacks.picker.grep({
          dirs = { "~/notes" },
          follow = true
        })
      end,
      desc = "Grep Notes"
    },
    {
      "<leader>nf",
      function()
        Snacks.picker.files({
          dirs = { "~/notes" },
          follow = true
        })
      end,
      desc = "Find Notes"
    }
  },
}
