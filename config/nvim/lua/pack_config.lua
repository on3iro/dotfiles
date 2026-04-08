vim.pack.add({
  -- Foundation
  "https://github.com/nvim-lua/plenary.nvim",

  -- Icons
  "https://github.com/echasnovski/mini.icons",

  -- Navigation & file browsing
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/mrjones2014/smart-splits.nvim",

  -- Search & picker
  "https://github.com/folke/snacks.nvim",

  -- LSP
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  -- Completion (pinned tag includes pre-built fuzzy binary)
  { src = "https://github.com/saghen/blink.cmp", checkout = "v1.10.2" },
  "https://github.com/rafamadriz/friendly-snippets",


  -- Treesitter
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", checkout = "main" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", checkout = "main" },
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
  "https://github.com/virchau13/tree-sitter-astro",
  "https://github.com/vrischmann/tree-sitter-templ",

  -- Formatting & linting
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/mfussenegger/nvim-lint",

  -- Git
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/sindrets/diffview.nvim",

  -- UI
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/arkav/lualine-lsp-progress",
  "https://github.com/sainnhe/everforest",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/folke/todo-comments.nvim",
  "https://github.com/iamcco/markdown-preview.nvim",

  -- AI
  "https://github.com/olimorris/codecompanion.nvim",
  "https://github.com/ravitemer/codecompanion-history.nvim",

  -- Text manipulation
  "https://github.com/kylechui/nvim-surround",
})

-- Post-install hooks
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name = ev.data.spec.name
    if name == "nvim-treesitter" then
      vim.cmd("TSUpdate")
    elseif name == "markdown-preview.nvim" then
      local plugin_path = vim.fn.stdpath("data") .. "/pack/core/opt/markdown-preview.nvim"
      vim.fn.jobstart("cd " .. plugin_path .. "/app && yarn install", { detach = true })
    end
  end,
})

-- Load plugin configurations (order matters: colorscheme and icons load first)
require("plugins.colorschemes")
require("plugins.icons")
require("plugins.snacks")
require("plugins.oil")
require("plugins.zellij-nav")
require("plugins.lsp")
require("plugins.blink")
require("plugins.treesitter")
require("plugins.conform-nvim")
require("plugins.nvim-lint")
require("plugins.gitsigns")
require("plugins.diffview")
require("plugins.lualine")
require("plugins.which_key")
require("plugins.todo-comments")
require("plugins.markdown-preview")
require("plugins.codecompanion")
require("plugins.nvim-surround")
