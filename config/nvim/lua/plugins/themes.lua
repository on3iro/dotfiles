return {
  {
    "sainnhe/everforest",
    enabled = true,
    config = function()
      vim.opt.background = "dark"
      vim.g.everforest_better_performance = 1
      vim.g.everforest_background = "hard"
      vim.g.everforest_ui_contrast = "high"
      vim.g.everforest_diagnostic_virtual_text = "colored"
      vim.g.everforest_enable_italic = 1
      vim.g.everforest_dim_inactive_windows = 1
      vim.g.everforest_transparent_background = 2
      vim.cmd("colorscheme everforest")
    end,
  },
}
