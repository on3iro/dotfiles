-- nvim-treesitter
vim.api.nvim_create_autocmd("User", {
  pattern = "TSUpdate",
  callback = function()
    local parsers = require("nvim-treesitter.parsers")
    parsers.templ = {
      install_info = {
        url = "https://github.com/vrischmann/tree-sitter-templ.git",
        files = { "src/parser.c", "src/scanner.c" },
        branch = "master",
      },
    }
    parsers.blade = {
      install_info = {
        url = "https://github.com/EmranMR/tree-sitter-blade",
        files = { "src/parser.c" },
        branch = "main",
      },
      filetype = "blade",
    }
    parsers.fusion = {
      install_info = {
        -- GitLab archive URLs are incompatible with nvim-treesitter's download
        -- mechanism. Clone manually once:
        --   git clone https://gitlab.com/jirgn/tree-sitter-fusion ~/.local/share/nvim/parsers/tree-sitter-fusion
        path = vim.fn.expand("~/.local/share/nvim/parsers/tree-sitter-fusion"),
        files = { "src/parser.c" },
      },
      filetype = "fusion",
    }
  end,
})

require("nvim-treesitter").setup()

-- Install parsers not bundled with Neovim 0.12
-- (bundled: bash, c, lua, markdown, markdown_inline, python, query, vim, vimdoc)
require("nvim-treesitter").install({
  "dart",
  "go",
  "rust",
  "typescript",
  "php",
  "html",
  "fusion",
  "templ",
})

-- Enable treesitter highlighting and indentation per filetype
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

vim.treesitter.language.register("templ", "templ")
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.blade.php",
  callback = function()
    vim.bo.filetype = "blade"
  end,
  group = vim.api.nvim_create_augroup("BladeFiltypeRelated", { clear = true })
})

-- nvim-treesitter-textobjects
require("nvim-treesitter-textobjects").setup({
  select = {
    enable = true,
    lookahead = true,
    keymaps = {
      ["aa"] = "@parameter.outer",
      ["ia"] = "@parameter.inner",
      ["af"] = "@function.outer",
      ["ab"] = "@block.outer",
      ["ib"] = "@block.inner",
      ["if"] = "@function.inner",
      ["ac"] = "@class.outer",
      ["ic"] = "@class.inner",
    },
  },
  move = {
    enable = true,
    set_jumps = true,
    goto_next_start = {
      ["]af"] = "@function.outer",
      ["]if"] = "@function.inner",
      ["]b"] = "@block.outer",
    },
    goto_next_end = {
      ["]ef"] = "@function.outer",
      ["]B"] = "@block.outer",
    },
    goto_previous_start = {
      ["[af"] = "@function.outer",
      ["[if"] = "@function.inner",
      ["[b"] = "@block.outer",
    },
    goto_previous_end = {
      ["[ef"] = "@function.outer",
      ["[B"] = "@block.outer",
    },
  },
  swap = {
    enable = true,
    swap_next = {
      [",a"] = "@parameter.inner",
    },
    swap_previous = {
      [",A"] = "@parameter.inner",
    },
  },
})

-- nvim-treesitter-context
require("treesitter-context").setup({
  enable = true,
  max_lines = 0,
  min_window_height = 0,
  line_numbers = true,
  multiline_threshold = 20,
  trim_scope = "outer",
  mode = "cursor",
  separator = nil,
  zindex = 20,
  on_attach = nil,
})
