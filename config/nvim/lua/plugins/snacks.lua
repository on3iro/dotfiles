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
    picker = { enabled = false },
    quickfile = { enabled = true },
    words = { enabled = true }
  },
  keys = {
    { "<leader>.", function() Snacks.scratch() end,        desc = "Toggle Scratch Buffer" },
    { "<leader>S", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
  }
}
