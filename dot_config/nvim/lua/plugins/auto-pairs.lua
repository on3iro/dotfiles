return {
	-- Bracket completion
	"windwp/nvim-autopairs",
  enabled = false,
	config = function()
		require("nvim-autopairs").setup({
			disable_filetype = { "TelescopePrompt", "vim", "markdown" },
			map_cr = true,
			check_ts = true,
		})
	end,
}
