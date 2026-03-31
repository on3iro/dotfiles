return {
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    keys = {
      { "<c-h>", function() require("smart-splits").move_cursor_left() end,  { silent = true, desc = "navigate left" } },
      { "<c-j>", function() require("smart-splits").move_cursor_down() end,  { silent = true, desc = "navigate down" } },
      { "<c-k>", function() require("smart-splits").move_cursor_up() end,    { silent = true, desc = "navigate up" } },
      { "<c-l>", function() require("smart-splits").move_cursor_right() end, { silent = true, desc = "navigate right" } },
    },
  },
  -- {
  --   "https://git.sr.ht/~swaits/zellij-nav.nvim",
  --   lazy = true,
  --   event = "VeryLazy",
  --   keys = {
  --     { "<c-h>", "<cmd>ZellijNavigateLeft<cr>",  { silent = true, desc = "navigate left or tab" } },
  --     { "<c-j>", "<cmd>ZellijNavigateDown<cr>",  { silent = true, desc = "navigate down" } },
  --     { "<c-k>", "<cmd>ZellijNavigateUp<cr>",    { silent = true, desc = "navigate up" } },
  --     { "<c-l>", "<cmd>ZellijNavigateRight<cr>", { silent = true, desc = "navigate right or tab" } },
  --   },
  --   opts = {},
  -- }
}
