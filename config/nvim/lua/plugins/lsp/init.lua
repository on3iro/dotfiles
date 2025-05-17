return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "yioneko/nvim-vtsls",
      "saghen/blink.cmp"
    },

    config = function()
      local mappings = require("plugins.lsp.mappings")

      -- LSP settings.
      --  This function gets run when an LSP connects to a particular buffer.
      local on_attach = function(client)
        mappings.init_lsp()
        vim.lsp.inlay_hint.enable(true)
      end

      local servers = require("plugins.lsp.servers")

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
      -- Setup mason so it can manage external tooling
      require("mason").setup()

      -- Ensure the servers above are installed
      require("mason-lspconfig").setup({
        ensure_installed = {
          "templ",
          "marksman",
          "intelephense"
        },
      })

      require("lspconfig.configs").vtsls = require("vtsls")
          .lspconfig -- set default server config, optional but recommended

      require("flutter-tools").setup({
        lsp = {
          on_attach = on_attach,
        },
        debugger = {
          enabled = true,
          register_configurations = function()
            -- require("dap").configurations.dart = {}
            -- require("dap.ext.vscode").load_launchjs()
          end,
        },
        fvm = true,
      })

      -------------
      -- Styling --
      -------------

      local border = {
        { "╭", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╮", "FloatBorder" },
        { "│", "FloatBorder" },
        { "╯", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╰", "FloatBorder" },
        { "│", "FloatBorder" },
      }

      -- To instead override globally
      local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or border
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
      end

      -- Diagnostics
      vim.diagnostic.config({
        virtual_text = false,
      })
    end,
  },

  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup({})
    end,
  },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },

  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = function() end,
  },
}
