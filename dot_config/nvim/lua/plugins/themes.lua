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
      vim.g.everforest_dim_inactive_windows = 1
      vim.g.everforest_transparent_background = 0
      vim.cmd("colorscheme everforest")
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    enabled = false,
    config = function()
      -- Default options:
      require("gruvbox").setup({
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "",  -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = true,
      })
      -- vim.o.background = "dark" -- or "light" for light mode
      -- vim.cmd([[colorscheme gruvbox]])
    end
  },
  {
    "gbprod/nord.nvim",
    lazy = false,
    enabled = false,
    priority = 1000,
    config = function()
      require("nord").setup({
        transparent = true
      })
      vim.cmd.colorscheme("nord")
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    config = function()
      -- Default options
      require("nightfox").setup({
        options = {
          -- Compiled file's destination location
          compile_path = vim.fn.stdpath("cache") .. "/nightfox",
          compile_file_suffix = "_compiled", -- Compiled file suffix
          transparent = false,               -- Disable setting background
          terminal_colors = true,            -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
          dim_inactive = true,               -- Non focused panes set to alternative background
          module_default = true,             -- Default enable value for modules
          colorblind = {
            enable = false,                  -- Enable colorblind support
            simulate_only = false,           -- Only show simulated colorblind colors and not diff shifted
            severity = {
              protan = 0,                    -- Severity [0,1] for protan (red)
              deutan = 0,                    -- Severity [0,1] for deutan (green)
              tritan = 0,                    -- Severity [0,1] for tritan (blue)
            },
          },
          styles = {             -- Style to be applied to different syntax groups
            comments = "italic", -- Value is any valid attr-list value `:help attr-list`
            conditionals = "NONE",
            constants = "NONE",
            functions = "NONE",
            keywords = "NONE",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "NONE",
            variables = "NONE",
          },
          inverse = { -- Inverse highlight for different types
            match_paren = false,
            visual = false,
            search = false,
          },
          modules = { -- List of various plugins and additional options
            -- ...
          },
        },
        palettes = {},
        specs = {},
        groups = {},
      })

      -- setup must be called before loading
      -- vim.cmd("colorscheme terafox")
      -- NOTE: theme is currently activated inside lualine!
    end,
  },
}
