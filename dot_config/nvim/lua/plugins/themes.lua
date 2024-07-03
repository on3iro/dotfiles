return {
	{
		"sainnhe/everforest",
		enabled = true,
		config = function()
			vim.opt.background = "dark"
			vim.g.everforest_better_performance = 1
			vim.g.everforest_background = "hard"
			vim.g.everforest_ui_contrast = "high"
			vim.g.everforest_diagnostic_virtual_text = "colored"
			vim.g.everforest_dim_inactive_windows = 1
			vim.g.everforest_transparent_background = 1
			vim.cmd("colorscheme everforest")
		end,
	},
	{
		"EdenEast/nightfox.nvim",
		config = function()
			-- Default options
			require("nightfox").setup({
				options = {
					-- Compiled file's destination location
					compile_path = vim.fn.stdpath("cache") .. "/nightfox",
					compile_file_suffix = "_compiled", -- Compiled file suffix
					transparent = false, -- Disable setting background
					terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
					dim_inactive = true, -- Non focused panes set to alternative background
					module_default = true, -- Default enable value for modules
					colorblind = {
						enable = false, -- Enable colorblind support
						simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
						severity = {
							protan = 0, -- Severity [0,1] for protan (red)
							deutan = 0, -- Severity [0,1] for deutan (green)
							tritan = 0, -- Severity [0,1] for tritan (blue)
						},
					},
					styles = { -- Style to be applied to different syntax groups
						comments = "italic", -- Value is any valid attr-list value `:help attr-list`
						conditionals = "NONE",
						constants = "NONE",
						functions = "NONE",
						keywords = "NONE",
						numbers = "NONE",
						operators = "NONE",
						strings = "NONE",
						types = "NONE",
						variables = "NONE",
					},
					inverse = { -- Inverse highlight for different types
						match_paren = false,
						visual = false,
						search = false,
					},
					modules = { -- List of various plugins and additional options
						-- ...
					},
				},
				palettes = {},
				specs = {},
				groups = {},
			})

			-- setup must be called before loading
			-- vim.cmd("colorscheme nordfox")
			-- NOTE: theme is currently activated inside lualine!
		end,
	},
}
