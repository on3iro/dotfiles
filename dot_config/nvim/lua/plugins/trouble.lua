return {
	"folke/trouble.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	cmd = "Trouble",
	opts = {},
	keys = {
		{
			"<leader>di",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>dq",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Quickfix List (Trouble)",
		},
	},
}
