return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "yioneko/nvim-vtsls",
      "saghen/blink.cmp"
    },

    config = function()
      local lspconfig = require("lspconfig")
      local mappings = require("plugins.lsp.mappings")
      local servers = require("plugins.lsp.servers")

      -- Function to detect project roots
      local function get_project_roots()
        local cwd = vim.fn.getcwd()
        local roots = {}

        -- Check for backend (Laravel/PHP)
        if vim.fn.isdirectory(cwd .. "/backend") == 1 then
          table.insert(roots, cwd .. "/backend")
        end

        -- Check for app (Flutter/Dart)
        if vim.fn.isdirectory(cwd .. "/app") == 1 then
          table.insert(roots, cwd .. "/app")
        end

        return roots
      end

      -- LSP settings.
      --  This function gets run when an LSP connects to a particular buffer.
      local on_attach = function(client, bufnr)
        mappings.init_lsp()
        vim.lsp.inlay_hint.enable(true)

        -- Add workspace folders for mono-repo
        local roots = get_project_roots()
        for _, root in ipairs(roots) do
          if not vim.tbl_contains(vim.lsp.buf.list_workspace_folders(), root) then
            vim.lsp.buf.add_workspace_folder(root)
          end
        end
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

      require("mason").setup()

      require("mason-lspconfig").setup({
        ensure_installed = {
          "templ",
          "marksman",
          "intelephense",
          "yamlls"
        },
      })

      -- PHP/Laravel LSP (intelephense)
      lspconfig.intelephense.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = function(fname)
          return lspconfig.util.root_pattern("composer.json", ".git")(fname)
              or lspconfig.util.root_pattern("composer.json")(fname .. "/backend")
              or vim.fn.getcwd() .. "/backend"
        end,
        settings = servers.intelephense or {},
      })

      -- YAML LSP
      lspconfig.yamlls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          yaml = servers.yaml or {},
        },
      })

      -- Other LSP servers with updated root detection
      for server, config in pairs(servers) do
        if server ~= "intelephense" and server ~= "yaml" then
          lspconfig[server].setup(vim.tbl_extend("force", {
            on_attach = on_attach,
            capabilities = capabilities,
          }, config))
        end
      end

      require("lspconfig.configs").vtsls = require("vtsls")
          .lspconfig -- set default server config, optional but recommended

      require("flutter-tools").setup({
        flutter_path = "/Users/theo/.local/share/mise/installs/flutter/3.29.3-stable/bin/flutter",
        root_patterns = { "pubspec.yaml", ".git" },
        lsp = {
          on_attach = on_attach,
          capabilities = capabilities,
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
    config = true,
  },
}
