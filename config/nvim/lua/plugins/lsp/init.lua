local mappings = require("plugins.lsp.mappings")
local servers = require("plugins.lsp.servers")

-- Function to detect project roots
local function get_project_roots()
  local cwd = vim.fn.getcwd()
  local roots = {}

  if vim.fn.isdirectory(cwd .. "/backend") == 1 then
    table.insert(roots, cwd .. "/backend")
  end

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

      if #potential_roots > 0 then
        return potential_roots[1].path
      end

      return nil
    end

    local file_dir = vim.fn.fnamemodify(fname, ":h")
    local flow_root = find_flow_root(file_dir)

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
    local backend_composer = cwd .. "/backend/composer.json"
    if vim.fn.filereadable(backend_composer) == 1 then
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
        associations = {
          "*.php",
          "*.phtml",
          "*.inc"
        },
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

-- LSP Attach autocmd
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf

    mappings.init_lsp()
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

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

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

vim.diagnostic.config({
  virtual_text = false,
})

-- typescript-tools
require("typescript-tools").setup({
  capabilities = vim.lsp.protocol.make_client_capabilities(),
})

-- flutter-tools
require("flutter-tools").setup({
  flutter_path = "/Users/theo/.local/share/mise/installs/flutter/3.32.7-stable/bin/flutter",
  root_patterns = { "pubspec.yaml", ".git" },
  lsp = {
    capabilities = vim.lsp.protocol.make_client_capabilities(),
  },
  debugger = {
    enabled = true,
    register_configurations = function()
    end,
  },
  fvm = true,
})
