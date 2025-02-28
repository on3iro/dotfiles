return {
  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    build = function()
      pcall(require("nvim-treesitter.install").update({ with_sync = true }))
    end,
    config = function()
      require("nvim-treesitter.configs").setup({
        -- Add languages to be installed here that you want installed for treesitter
        ensure_installed = {
          "c",
          "go",
          "lua",
          "python",
          "rust",
          "typescript",
          "fusion",
          "php",
          "vimdoc",
          "markdown",
          "templ",
        },

        highlight = { enable = true },
        indent = { enable = true, disable = { "python", "markdown" } },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-s>",
            node_decremental = "<c-backspace>",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
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
            set_jumps = true, -- whether to set jumps in the jumplist
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
        },
      })

      local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      treesitter_parser_config.templ = {
        install_info = {
          url = "https://github.com/vrischmann/tree-sitter-templ.git",
          files = { "src/parser.c", "src/scanner.c" },
          branch = "master",
        },
      }

      vim.treesitter.language.register("templ", "templ")
    end,
  },

  "nvim-treesitter/nvim-treesitter-textobjects",

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
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20,     -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      })
    end,
  },

  "vrischmann/tree-sitter-templ",
}
