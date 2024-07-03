return {
	-- Git related plugins
	"f-person/git-blame.nvim",

	-- Colors
	{
		"sainnhe/everforest",
		config = function()
			vim.opt.background = "dark"
			vim.g.everforest_better_performance = 1
			vim.g.everforest_background = "hard"
			vim.g.everforest_ui_contrast = "high"
			vim.g.everforest_diagnostic_virtual_text = "colored"
			-- g.everforest_transparent_background = 1
			vim.cmd("colorscheme everforest")
		end,
	},

	-- Icons
	"kyazdani42/nvim-web-devicons",

	-- Color highlighter
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	-- Scrollbar
	{
		"petertriho/nvim-scrollbar",
		config = function()
			require("scrollbar").setup()
		end,
	},

	-- Buffer navigation
	{
		"ThePrimeagen/harpoon",
		config = function()
			vim.api.nvim_set_keymap(
				"n",
				"<leader>hh",
				":lua require('harpoon.ui').toggle_quick_menu()<cr>",
				{ noremap = false }
			)

			vim.api.nvim_set_keymap(
				"n",
				"<leader>ha",
				":lua require('harpoon.mark').add_file()<cr>",
				{ noremap = true }
			)

			vim.api.nvim_set_keymap("n", "]h", ":lua require('harpoon.ui').nav_next()<cr>", { noremap = true })
			vim.api.nvim_set_keymap("n", "[h", ":lua require('harpoon.ui').nav_prev()<cr>", { noremap = true })

			vim.api.nvim_set_keymap("n", "<leader>h1", ":lua require('harpoon.ui').nav_file(1)<cr>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<leader>h2", ":lua require('harpoon.ui').nav_file(2)<cr>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<leader>h3", ":lua require('harpoon.ui').nav_file(3)<cr>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<leader>h4", ":lua require('harpoon.ui').nav_file(4)<cr>", { noremap = true })
		end,
	},
}
