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
    },
  },
  keys = {
    -- Scratch buffers
    { "<leader>.",  function() Snacks.scratch() end,              desc = "Toggle Scratch Buffer" },
    { "<leader>S",  function() Snacks.scratch.select() end,       desc = "Select Scratch Buffer" },

    ------------
    -- Picker --
    ------------

    -- Todo/Fixme/Note comments
    { "<leader>td", function() Snacks.picker.todo_comments() end, desc = "Todo" },

    -- Files
    { "<leader>ff", function() Snacks.picker.files() end,         desc = "Find Files" },
    { "<leader>bu", function() Snacks.picker.buffers() end,       desc = "Buffers" },

    -- Grep
    { "<leader>fw", function() Snacks.picker.grep_word() end,     desc = "Visual selection or word", mode = { "n", "x" } },
    { "<leader>/",  function() Snacks.picker.grep() end,          desc = "Grep" },
  }
}
