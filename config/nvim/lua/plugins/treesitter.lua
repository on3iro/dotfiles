return {
  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
      -- Custom parsers must be injected via TSUpdate autocmd.
      -- install.lua calls reload_parsers() which wipes package.loaded before
      -- each run, then fires this event — so this is the only place assignments survive.
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
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
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
    end,
  },

  "virchau13/tree-sitter-astro",

  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        trim_scope = "outer",     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = "cursor",          -- Line used to calculate context. Choices: 'cursor', 'topline'
        separator = nil,
        zindex = 20,     -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      })
    end,
  },

  "vrischmann/tree-sitter-templ",
}
