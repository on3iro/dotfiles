local a = vim.api

return {
	-- nvim-tree
	"kyazdani42/nvim-tree.lua",
	config = function()
		require("nvim-tree").setup({
			-- disables netrw completely
			disable_netrw = true,
			-- hijack netrw window on startup
			hijack_netrw = true,
			-- opens the tree when changing/opening a new tab if the tree wasn't previously opened
			open_on_tab = false,
			respect_buf_cwd = true,
			-- hijacks new directory buffers when they are opened.
			git = {
				enable = true,
				ignore = false,
				timeout = 500,
			},
			-- hijack the cursor in the tree to put it at the start of the filename
			hijack_cursor = false,
			-- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
			update_cwd = false,
			-- show lsp diagnostics in the signcolumn
			diagnostics = {
				enable = false,
				icons = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				},
			},
			-- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
			update_focused_file = {
				-- enables the feature
				enable = true,
				-- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
				-- only relevant when `update_focused_file.enable` is true
				update_cwd = true,
				-- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
				-- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
				ignore_list = {},
			},
			-- configuration options for the system open command (`s` in the tree by default)
			system_open = {
				-- the command to run this, leaving nil should work in most cases
				cmd = nil,
				-- the command arguments as a list
				args = {},
			},

			view = {
				-- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
				width = 30,
				-- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
				side = "right",
				mappings = {
					-- custom only false will merge the list with the default mappings
					-- if true, it will only use your list to set the mappings
					custom_only = false,
					-- list of mappings to set on the tree manually
					list = {},
				},
			},
		})

		a.nvim_set_keymap("n", "<leader>nt", ":NvimTreeToggle<cr>", { noremap = false })
		a.nvim_set_keymap("n", "<leader>nf", ":NvimTreeFindFile<cr>", { noremap = false })
	end,
}
