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

          -- Helper function to find Neos/Flow project root
          local function find_flow_root(start_path)
            local current = start_path
            local potential_roots = {}

            while current and current ~= "/" do
              -- Look for Flow/Neos indicators
              local flow_yaml = current .. "/Configuration/Settings.yaml"
              local flow_routes = current .. "/Configuration/Routes.yaml"
              local packages_dir = current .. "/Packages"
              local dist_packages_dir = current .. "/DistributionPackages"
              local main_composer = current .. "/composer.json"

              -- Check if this directory contains Flow application structure
              local has_flow_config = vim.fn.filereadable(flow_yaml) == 1 or vim.fn.filereadable(flow_routes) == 1
              local has_packages = vim.fn.isdirectory(packages_dir) == 1 or vim.fn.isdirectory(dist_packages_dir) == 1
              local has_composer = vim.fn.filereadable(main_composer) == 1

              if (has_flow_config or has_packages) and has_composer then
                -- Determine priority: main application root (contains DistributionPackages/Packages)
                -- is preferred over individual package roots
                local priority = 0

                -- Higher priority for directories that contain DistributionPackages or Packages
                if vim.fn.isdirectory(dist_packages_dir) == 1 or vim.fn.isdirectory(packages_dir) == 1 then
                  priority = 2
                  -- Lower priority for directories that just have Flow config (likely individual packages)
                elseif has_flow_config then
                  priority = 1
                end

                table.insert(potential_roots, { path = current, priority = priority })
              end

              -- Move up one directory
              current = vim.fn.fnamemodify(current, ":h")
            end

            -- Sort by priority (highest first) and return the best match
            table.sort(potential_roots, function(a, b) return a.priority > b.priority end)

            if #potential_roots > 0 then
              local best_root = potential_roots[1].path
              return best_root
            end

            return nil
          end

          -- Start from the file's directory and work upwards
          local file_dir = vim.fn.fnamemodify(fname, ":h")

          local flow_root = find_flow_root(file_dir)

          if flow_root then
            on_dir(flow_root)
            return
          end

          -- Fallback to standard root patterns
          local root = util.root(bufnr, { 'composer.json', '.git' })
          if root then
            on_dir(root)
            return
          end

          -- Try backend subdirectory (for your Laravel setup)
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
        settings = vim.tbl_extend("force", servers.intelephense or {}, {
          intelephense = {
            files = {
              -- Include common Neos/Flow paths
              associations = {
                "*.php",
                "*.phtml",
                "*.inc"
              },
              maxSize = 5000000,
              -- Exclude cache and temporary directories common in Flow projects
              exclude = {
                "**/Data/Temporary/**",
                "**/Data/Logs/**",
                "**/Web/_Resources/**",
                "**/node_modules/**",
                "**/vendor/**/{Tests,tests}/**"
              }
            },
            -- Enable stubs for better Flow/Neos support
            stubs = {
              "apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core", "ctype",
              "curl", "date", "dba", "dom", "enchant", "exif", "fileinfo", "filter",
              "fpm", "ftp", "gd", "hash", "iconv", "imap", "interbase", "intl",
              "json", "ldap", "libxml", "mbstring", "mcrypt", "meta", "mssql",
              "mysql", "mysqli", "oci8", "odbc", "openssl", "pcntl", "pcre", "PDO",
              "pdo_ibm", "pdo_mysql", "pdo_pgsql", "pdo_sqlite", "pgsql", "Phar",
              "posix", "pspell", "readline", "recode", "Reflection", "regex", "session",
              "shmop", "SimpleXML", "snmp", "soap", "sockets", "sodium", "SPL",
              "sqlite3", "standard", "superglobals", "sybase", "sysvmsg", "sysvsem",
              "sysvshm", "tidy", "tokenizer", "xml", "xmlreader", "xmlrpc", "xmlwriter",
              "Zend OPcache", "zip", "zlib"
            }
          }
        }),
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
