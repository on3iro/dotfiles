return {
  {
    -- Keep Mason for LSP server installation
    "mason-org/mason.nvim",
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      "saghen/blink.cmp"
    },

    config = function()
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

      -- Set global defaults for all LSP clients
      vim.lsp.config('*', {
        capabilities = capabilities,
        root_markers = { '.git' },
      })

      -- Configure PHP/Laravel LSP (intelephense) with custom root detection
      vim.lsp.config.intelephense = {
        filetypes = { 'php' },
        root_dir = function(bufnr, on_dir)
          local fname = vim.api.nvim_buf_get_name(bufnr)
          local util = require('vim.fs')
          
          -- Try standard root patterns first
          local root = util.root(bufnr, { 'composer.json', '.git' })
          if root then
            on_dir(root)
            return
          end
          
          -- Try backend subdirectory
          local cwd = vim.fn.getcwd()
          local backend_composer = cwd .. "/backend/composer.json"
          if vim.fn.filereadable(backend_composer) == 1 then
            on_dir(cwd .. "/backend")
            return
          end
          
          -- Fallback to backend directory if it exists
          if vim.fn.isdirectory(cwd .. "/backend") == 1 then
            on_dir(cwd .. "/backend")
          end
        end,
        settings = servers.intelephense or {},
      }

      -- Configure YAML LSP
      vim.lsp.config.yamlls = {
        filetypes = { 'yaml', 'yml' },
        root_markers = { '.git', 'package.json' },
        settings = {
          yaml = servers.yaml or {},
        },
      }

      -- Configure other servers from servers.lua
      for server, config in pairs(servers) do
        if server ~= "intelephense" and server ~= "yaml" then
          -- Determine filetypes based on server name
          local filetypes = {}
          if server == "gopls" then
            filetypes = { "go", "gomod", "gowork", "gotmpl" }
          elseif server == "rust_analyzer" then
            filetypes = { "rust" }
          elseif server == "templ" then
            filetypes = { "templ" }
          elseif server == "marksman" then
            filetypes = { "markdown" }
          end

          vim.lsp.config[server] = vim.tbl_extend("force", {
            filetypes = filetypes,
            settings = config,
          }, {})
        end
      end

      -- Enable all configured servers
      local servers_to_enable = { "intelephense", "yamlls" }
      for server, _ in pairs(servers) do
        if server ~= "intelephense" and server ~= "yaml" then
          table.insert(servers_to_enable, server)
        end
      end
      
      vim.lsp.enable(servers_to_enable)

      -- LSP Attach autocmd to replace on_attach function
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          local bufnr = args.buf
          
          mappings.init_lsp()
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

          -- Add workspace folders for mono-repo
          local roots = get_project_roots()
          for _, root in ipairs(roots) do
            if not vim.tbl_contains(vim.lsp.buf.list_workspace_folders(), root) then
              vim.lsp.buf.add_workspace_folder(root)
            end
          end
        end
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
    dependencies = { 
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig" -- typescript-tools requires lspconfig internally
    },
    config = function()
      require("typescript-tools").setup({
        capabilities = vim.lsp.protocol.make_client_capabilities(),
      })
    end,
  },

  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = function()
      require("flutter-tools").setup({
        flutter_path = "/Users/theo/.local/share/mise/installs/flutter/3.29.3-stable/bin/flutter",
        root_patterns = { "pubspec.yaml", ".git" },
        lsp = {
          -- Flutter-tools will handle its own LSP setup
          capabilities = vim.lsp.protocol.make_client_capabilities(),
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
    end,
  },
}
