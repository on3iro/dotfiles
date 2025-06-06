return {
  {
    "sainnhe/everforest",
    enabled = true,
    config = function()
      vim.opt.background = "dark"
      vim.g.everforest_background = "medium"
      vim.g.everforest_ui_contrast = "high"
      vim.g.everforest_diagnostic_virtual_text = "colored"
      vim.g.everforest_enable_italic = 1
      vim.g.everforest_dim_inactive_windows = 1
      vim.g.everforest_transparent_background = 0
      vim.cmd("colorscheme everforest")
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "latte", -- latte, frappe, macchiato, mocha
      })
    end
  }
}
