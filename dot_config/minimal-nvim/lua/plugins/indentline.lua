return {
	-- Indent line
	"lukas-reineke/indent-blankline.nvim",
	config = function()
		require("indent_blankline").setup({
			char = "┊",
			-- for example, context is off by default, use this to turn it on
			show_current_context = true,
			show_current_context_start = false,
			context_char = "┃",
			use_treesitter = true,
		})
	end,
}
