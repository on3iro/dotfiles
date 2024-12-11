return {
  -- Fuzzy Finder (files, lsp, etc)
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "BurntSushi/ripgrep",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      local a = vim.api

      local previewers = require("telescope.previewers")

      -- Ignore files bigger then threshol (e.g. images)
      local new_maker = function(filepath, bufnr, opts)
        opts = opts or {}

        filepath = vim.fn.expand(filepath)
        vim.loop.fs_stat(filepath, function(_, stat)
          if not stat then
            return
          end
          if stat.size > 100000 then
            return
          else
            previewers.buffer_previewer_maker(filepath, bufnr, opts)
          end
        end)
      end

      actions = require("telescope.actions")
      builtins = require("telescope.builtin")

      require("telescope").setup({
        -- ...
        defaults = {
          layout_strategy = "vertical",
          layout_config = {
            vertical = {
              prompt_position = "bottom",
              width = { padding = 0 },
              height = { padding = 0 },
              preview_height = 0.6,
              preview_cutoff = 10,
            },
          },
          wrap_results = true,
          buffer_previewer_maker = new_maker,
          file_ignore_patterns = { "node_modules", "%.git/" },
          path_display = {
            -- shorten = true,
            truncate = 3,
          },
          -- Old style arguments as a quickfix for ripgrep memory leak
          -- see: https://github.com/nvim-telescope/telescope.nvim/issues/2482#issuecomment-1528053505
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
          },
          mappings = {
            i = {
              ["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
              ["<C-s>"] = actions.cycle_previewers_next,
              ["<C-a>"] = actions.cycle_previewers_prev,
              ["<C-d>"] = actions.preview_scrolling_down,
              ["<C-u>"] = actions.preview_scrolling_up,
            },
          },
        },
        pickers = {
          find_files = {},
          grep_string = {},
          buffers = {},
          live_grep = {},
          current_buffer_fuzzy_find = {},
          oldfiles = {},
          quickfix = { fname_width = 80 },
          lsp_references = { fname_width = 0.6 },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              -- even more opts
            }),

            -- pseudo code / specification for writing custom displays, like the one
            -- for "codeactions"
            -- specific_opts = {
            --   [kind] = {
            --     make_indexed = function(items) -> indexed_items, width,
            --     make_displayer = function(widths) -> displayer
            --     make_display = function(displayer) -> function(e)
            --     make_ordinal = function(e) -> string
            --   },
            --   -- for example to disable the custom builtin "codeactions" display
            --      do the following
            --   codeactions = false,
            -- }
          },
        },
      })

      require("telescope").load_extension("fzf")
      require("telescope").load_extension("ui-select")

      require("plugins.flutter.telescope").setup()

      -- Files
      a.nvim_set_keymap("n", "<leader>f", "<cmd>Telescope find_files hidden=true<cr>", { noremap = false })
      a.nvim_set_keymap("n", "<leader>nw", "<cmd>Telescope grep_string<cr>", { noremap = false })
      a.nvim_set_keymap("n", "<leader>bu", "<cmd>Telescope buffers<cr>", { noremap = false })
      a.nvim_set_keymap("n", "<leader>/", "<cmd>Telescope live_grep<cr>", { noremap = false })
      a.nvim_set_keymap("n", "<leader>l", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { noremap = false })
      a.nvim_set_keymap("n", "<leader>hi", "<cmd>Telescope oldfiles<cr>", { noremap = false })
      local builtin = require("telescope.builtin")

      -- Notes
      vim.keymap.set("n", "<leader>n/", function()
        builtin.live_grep({
          additional_args = {
            "-L", -- Follow symbolic links
          },
          search_dirs = {
            "~/notes",
          },
        })
      end, { noremap = false })
      vim.keymap.set("n", "<leader>nf", function()
        builtin.find_files({
          follow = true, -- Follow symbolic links
          search_dirs = {
            "~/notes",
          },
        })
      end, { noremap = false })

      vim.keymap.set("n", "<leader>nt", "<cmd>lua live_grep_frontmatter_tags()<cr>", { noremap = true })

      -- Git
      a.nvim_set_keymap("n", "<leader>gc", "<cmd>Telescope git_bcommits<cr>",
        { noremap = false, desc = "Git buffer commits" })
      a.nvim_set_keymap("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { noremap = false })
      a.nvim_set_keymap("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { noremap = false })

      -- nvim
      a.nvim_set_keymap("n", "<leader>re", "<cmd>Telescope registers<cr>", { noremap = false })
      a.nvim_set_keymap("n", "<leader>ma", "<cmd>Telescope marks<cr>", { noremap = false })
      a.nvim_set_keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { noremap = false })
    end,
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
}
