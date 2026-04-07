vim.opt.laststatus = 3

local theme = require("lualine.themes.everforest")
theme.insert.a.fg = "#282a36"
theme.insert.a.bg = "orange"
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
    section_separators = { left = "", right = "" },
  },

  sections = {
    lualine_a = { {
      'mode',
      icons_enabled = true,
      icon = '',
      right_padding = 2
    } },
    lualine_b = {
      {
        "diagnostics",
        sources = { "nvim_lsp" },
      },
    },
    lualine_c = {
      { lint_progress },
      {
        "filename",
        file_status = true,
        path = 2,
        shorting_target = 40,
      },
    },
    lualine_x = { 'encoding', 'fileformat', { 'filetype', icon_only = true } },
    lualine_y = {},

    lualine_z = {
      "lsp_progress",
      {
        'location',
        left_padding = 2
      },
    },
  },
  winbar = {
    lualine_a = {
      {
        "filename",
        file_status = true,
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
        file_status = true,
        path = 2,
        shorting_target = 40,
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
