local mappings = require("plugins.lsp.mappings")
local servers = require("plugins.lsp.servers")

local capabilities = require("blink.cmp").get_lsp_capabilities()

require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    "templ",
    "marksman",
    "intelephense",
    "yamlls",
    "ts_ls",
  },
})

-- Global defaults for all LSP clients
vim.lsp.config('*', {
  capabilities = capabilities,
  root_markers = { '.git' },
})

-- Go
vim.lsp.config.gopls = {
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  settings = servers.gopls,
}

-- Rust
vim.lsp.config.rust_analyzer = {
  filetypes = { "rust" },
  settings = servers.rust_analyzer,
}

-- Templ
vim.lsp.config.templ = { filetypes = { "templ" } }

-- Markdown
vim.lsp.config.marksman = { filetypes = { "markdown" } }

-- TypeScript / JavaScript
vim.lsp.config.ts_ls = {
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  root_markers = { "tsconfig.json", "package.json", ".git" },
}

-- Dart / Flutter (dart binary is in PATH via mise shims)
vim.lsp.config.dartls = {
  cmd = { "dart", "language-server", "--protocol=lsp" },
  filetypes = { "dart" },
  root_markers = { "pubspec.yaml", ".git" },
}

-- YAML
vim.lsp.config.yamlls = {
  filetypes = { 'yaml', 'yml' },
  root_markers = { '.git', 'package.json' },
  settings = {
    yaml = servers.yaml or {},
  },
}

-- PHP (Intelephense) with custom root detection for Flow/Neos projects
vim.lsp.config.intelephense = {
  filetypes = { 'php' },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local util = require('vim.fs')

    local function find_flow_root(start_path)
      local current = start_path
      local potential_roots = {}

      while current and current ~= "/" do
        local flow_yaml = current .. "/Configuration/Settings.yaml"
        local flow_routes = current .. "/Configuration/Routes.yaml"
        local packages_dir = current .. "/Packages"
        local dist_packages_dir = current .. "/DistributionPackages"
        local main_composer = current .. "/composer.json"

        local has_flow_config = vim.fn.filereadable(flow_yaml) == 1 or vim.fn.filereadable(flow_routes) == 1
        local has_packages = vim.fn.isdirectory(packages_dir) == 1 or vim.fn.isdirectory(dist_packages_dir) == 1
        local has_composer = vim.fn.filereadable(main_composer) == 1

        if (has_flow_config or has_packages) and has_composer then
          local priority = 0

          if vim.fn.isdirectory(dist_packages_dir) == 1 or vim.fn.isdirectory(packages_dir) == 1 then
            priority = 2
          elseif has_flow_config then
            priority = 1
          end

          table.insert(potential_roots, { path = current, priority = priority })
        end

        current = vim.fn.fnamemodify(current, ":h")
      end

      table.sort(potential_roots, function(a, b) return a.priority > b.priority end)
      return #potential_roots > 0 and potential_roots[1].path or nil
    end

    local flow_root = find_flow_root(vim.fn.fnamemodify(fname, ":h"))
    if flow_root then
      on_dir(flow_root)
      return
    end

    local root = util.root(bufnr, { 'composer.json', '.git' })
    if root then
      on_dir(root)
      return
    end

    local cwd = vim.fn.getcwd()
    if vim.fn.filereadable(cwd .. "/backend/composer.json") == 1 then
      on_dir(cwd .. "/backend")
      return
    end

    if vim.fn.isdirectory(cwd .. "/backend") == 1 then
      on_dir(cwd .. "/backend")
    end
  end,
  settings = vim.tbl_extend("force", servers.intelephense or {}, {
    intelephense = {
      files = {
        associations = { "*.php", "*.phtml", "*.inc" },
        maxSize = 5000000,
        exclude = {
          "**/Data/Temporary/**",
          "**/Data/Logs/**",
          "**/Web/_Resources/**",
          "**/node_modules/**",
          "**/vendor/**/{Tests,tests}/**"
        }
      },
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

vim.lsp.enable({ "gopls", "rust_analyzer", "intelephense", "yamlls", "templ", "marksman", "ts_ls", "dartls" })

-- Run on LSP attach
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf

    mappings.init_lsp()
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

    -- Add workspace folders for monorepo layouts (backend/ and app/ subdirs)
    local cwd = vim.fn.getcwd()
    for _, subdir in ipairs({ "/backend", "/app" }) do
      local path = cwd .. subdir
      if vim.fn.isdirectory(path) == 1
        and not vim.tbl_contains(vim.lsp.buf.list_workspace_folders(), path)
      then
        vim.lsp.buf.add_workspace_folder(path)
      end
    end
  end
})

-------------
-- Styling --
-------------

local border = {
  { "╭", "FloatBorder" }, { "─", "FloatBorder" }, { "╮", "FloatBorder" },
  { "│", "FloatBorder" }, { "╯", "FloatBorder" }, { "─", "FloatBorder" },
  { "╰", "FloatBorder" }, { "│", "FloatBorder" },
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

vim.diagnostic.config({ virtual_text = false })
