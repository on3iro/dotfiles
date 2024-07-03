return {
	{
		-- Status bar
		"nvim-lualine/lualine.nvim", -- Fancier statusline
		config = function() -- Lua
			-- vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text
			-- vim.g.gitblame_message_template = "<author> <sha>"
			-- local git_blame = require("gitblame")

			-- Only ever show a single status line
			vim.opt.laststatus = 2

			-- vim.cmd("colorscheme nightfox")
			--
			local theme = require("lualine.themes.nightfox")
			theme.insert.a.fg = "#282a36"
			theme.insert.a.bg = "turquoise"
			-- theme.insert.a.gui = "none"
			theme.normal.a.fg = "turquoise"
			theme.normal.a.bg = "#282a36"
			theme.normal.a.gui = "none"
			theme.visual.a.gui = "none"
			theme.replace.a.gui = "none"

			require("lualine").setup({
				options = {
					theme = theme,
					component_separators = "",
					section_separators = { left = "", right = "" },
				},

				sections = {
					lualine_a = { "mode" },
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
						{
							"filename",
							file_status = true, -- displays file status (readonly status, modified status)
							path = 2, -- 0 = just filename, 1 = relative path, 3 = absolute path
							shorting_target = 40, -- Shortens path to leave 40 space in the window
						},
					},

					lualine_z = {
						"lsp_progress",
						-- { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available },
					},
				},
				winbar = {
					lualine_a = { "filename" },
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
			})
		end,
	},
	{
		"arkav/lualine-lsp-progress",
	},
}
