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
    quickfile = { enabled = true },
    words = { enabled = true },
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
      ui_select = true, -- replace `vim.ui.select` with the snacks picker
      win = {
        input = {
          keys = {
            ["<c-t>"] = { "toggle_live", mode = { "i", "n" } },
          },
        },
      },
    },
  },
  keys = {
    -- Scratch buffers
    { "<leader>.",   function() Snacks.scratch() end,                      desc = "Toggle Scratch Buffer" },
    { "<leader>S",   function() Snacks.scratch.select() end,               desc = "Select Scratch Buffer" },

    ------------
    -- Picker --
    ------------

    -- Todo/Fixme/Note comments
    { "<leader>td",  function() Snacks.picker.todo_comments() end,         desc = "Todo" },
    -- Files
    { "<leader>ff",  function() Snacks.picker.files() end,                 desc = "Find Files" },
    { "<leader>bu",  function() Snacks.picker.buffers() end,               desc = "Buffers" },
    { "<leader>hi",  function() Snacks.picker.recent() end,                desc = "Recent" },
    { "<leader>zo",  function() Snacks.picker.zoxide() end,                desc = "Zoxide" },
    -- Grep
    { "<leader>fw",  function() Snacks.picker.grep_word() end,             desc = "Visual selection or word", mode = { "n", "x" } },
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
  }
}
