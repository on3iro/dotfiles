return {
	{
		"LunarVim/bigfile.nvim",
	},

	-- Git related plugins
	{
		"f-person/git-blame.nvim",
		opts = {
			enabled = false,
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},

	-- Icons
	"nvim-tree/nvim-web-devicons",

	------------------
	-- [ MARKDOWN ] --
	------------------

	-- Instant markdown preview
	{ "iamcco/markdown-preview.nvim", build = "cd app && yarn install" },

	-- Color highlighter
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	"docteurklein/php-getter-setter.vim",

	{
		"mbbill/undotree",
		config = function()
			vim.api.nvim_set_keymap("n", "<leader>ut", ":UndotreeToggle<cr>", { noremap = true })
		end,
	},

	"imsnif/kdl.vim",

	"NoahTheDuke/vim-just",
}
