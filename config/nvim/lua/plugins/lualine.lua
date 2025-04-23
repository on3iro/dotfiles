return {
  {
    -- Status bar
    "nvim-lualine/lualine.nvim", -- Fancier statusline
    config = function()          -- Lua
      -- local git_blame = require("gitblame")

      -- Only ever show a single status line -> 2
      -- global status line -> 3
      vim.opt.laststatus = 3

      local theme = require("lualine.themes.everforest")
      theme.insert.a.fg = "#282a36"
      theme.insert.a.bg = "turquoise"
      -- theme.insert.a.gui = "none"
      theme.normal.a.fg = "#282a36"
      theme.normal.a.bg = "orange"
      theme.normal.a.gui = "none"
      theme.visual.a.gui = "none"
      theme.replace.a.gui = "none"

      local lint_progress = function()
        local linters = require("lint").get_running()
        if #linters == 0 then
          return "󰦕"
        end
        return "󱉶 " .. table.concat(linters, ", ")
      end

      require("lualine").setup({
        options = {
          theme = theme,
          component_separators = "",
          section_separators = { left = "", right = "" },
          -- section_separators = { left = '', right = '' },
        },

        sections = {
          lualine_a = { {
            'mode',
            icons_enabled = true,
            icon = '',
            -- separator = { left = '', right = '' },
            right_padding = 2
          } },
          lualine_b = {
            {
              "diagnostics",
              -- table of diagnostic sources, available sources:
              -- 'nvim_lsp', 'nvim', 'coc', 'ale', 'vim_lsp'
              -- Or a function that returns a table like
              --   {error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt}
              sources = { "nvim_lsp" },
              -- displays diagnostics from defined severity
              -- sections = {'error', 'warn', 'info', 'hint'},
              -- all colors are in format #rrggbb
              -- diagnostics_color = {
              --   error = nil, -- changes diagnostic's error color
              --   warn = nil,  -- changes diagnostic's warn color
              --   info = nil,  -- Changes diagnostic's info color
              --   hint = nil,  -- Changes diagnostic's hint color
              -- },
              -- symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
              -- colored = true, -- displays diagnostics status in color if set to true
              -- update_in_insert = false, -- Update diagnostics in insert mode
              -- always_visible = false, -- Show diagnostics even if count is 0, boolean or function returning boolean
            },
          },
          lualine_c = {
            { lint_progress },
            {
              "filename",
              file_status = true,   -- displays file status (readonly status, modified status)
              path = 2,             -- 0 = just filename, 1 = relative path, 3 = absolute path
              shorting_target = 40, -- Shortens path to leave 40 space in the window
            },
            -- { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available }
          },
          lualine_x = { 'encoding', 'fileformat', { 'filetype', icon_only = true } },
          lualine_y = {},

          lualine_z = {
            "lsp_progress",
            {
              'location',
              -- separator = { left = '', right = '' },
              left_padding = 2
            },
            -- { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available },
          },
        },
        winbar = {
          lualine_a = {
            {
              "filename",
              file_status = true, -- displays file status (readonly status, modified status)
            },
            { "filetype", icon_only = true }
          },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        inactive_winbar = {
          lualine_a = {
            {
              "filename",
              file_status = true,   -- displays file status (readonly status, modified status)
              path = 2,             -- 0 = just filename, 1 = relative path, 3 = absolute path
              shorting_target = 40, -- Shortens path to leave 40 space in the window
            },
            { "filetype",    icon_only = true },
            { separator = "" },
          },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        }
      })
    end,
  },
  {
    "arkav/lualine-lsp-progress",
  },
}
