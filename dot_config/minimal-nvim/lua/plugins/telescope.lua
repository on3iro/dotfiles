return {
	-- Fuzzy Finder (files, lsp, etc)
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"BurntSushi/ripgrep",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			local a = vim.api

			local previewers = require("telescope.previewers")

			-- Ignore files bigger then threshol (e.g. images)
			local new_maker = function(filepath, bufnr, opts)
				opts = opts or {}

				filepath = vim.fn.expand(filepath)
				vim.loop.fs_stat(filepath, function(_, stat)
					if not stat then
						return
					end
					if stat.size > 100000 then
						return
					else
						previewers.buffer_previewer_maker(filepath, bufnr, opts)
					end
				end)
			end

			require("telescope").setup({
				-- ...
				defaults = {
					buffer_previewer_maker = new_maker,
					file_ignore_patterns = { "node_modules", "%.git/" },
					path_display = {
						truncate = 3,
					},
				},
				mappings = {
					i = {
						["<C-q>"] = require("telescope.actions").smart_send_to_qflist
							+ require("telescope.actions").open_qflist,
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),

						-- pseudo code / specification for writing custom displays, like the one
						-- for "codeactions"
						-- specific_opts = {
						--   [kind] = {
						--     make_indexed = function(items) -> indexed_items, width,
						--     make_displayer = function(widths) -> displayer
						--     make_display = function(displayer) -> function(e)
						--     make_ordinal = function(e) -> string
						--   },
						--   -- for example to disable the custom builtin "codeactions" display
						--      do the following
						--   codeactions = false,
						-- }
					},
				},
			})

			require("telescope").load_extension("fzf")
			require("telescope").load_extension("ui-select")

			local builtin = require("telescope.builtin")

			-- Files
			a.nvim_set_keymap("n", "<leader>ne", "<cmd>Telescope find_files hidden=true<cr>", { noremap = false })
			a.nvim_set_keymap("n", "<leader>nw", "<cmd>Telescope grep_string<cr>", { noremap = false })
			a.nvim_set_keymap("n", "<leader>nb", "<cmd>Telescope buffers<cr>", { noremap = false })
			a.nvim_set_keymap("n", "<leader>na", "<cmd>Telescope live_grep<cr>", { noremap = false })
			a.nvim_set_keymap("n", "<leader>nl", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { noremap = false })
			a.nvim_set_keymap("n", "<leader>nh", "<cmd>Telescope oldfiles<cr>", { noremap = false })

			-- Notes
			vim.keymap.set("n", "<leader>nna", function()
				builtin.live_grep({
					search_dirs = {
						"~/vimwiki",
						"~/vw_sandstorm",
						"~/orgmode",
						"~/Nextcloud/Notes",
					},
				})
			end, { noremap = false })
			vim.keymap.set("n", "<leader>nne", function()
				builtin.find_files({
					search_dirs = {
						"~/vimwiki",
						"~/vw_sandstorm",
						"~/orgmode",
						"~/Nextcloud/Notes",
					},
				})
			end, { noremap = false })

			-- Git
			a.nvim_set_keymap("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { noremap = false })
			a.nvim_set_keymap("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { noremap = false })
			a.nvim_set_keymap("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { noremap = false })

			-- Registers
			a.nvim_set_keymap("n", "<leader>re", "<cmd>Telescope registers<cr>", { noremap = false })

			-- Marks
			a.nvim_set_keymap("n", "<leader>ma", "<cmd>Telescope marks<cr>", { noremap = false })
		end,
	},

	-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
}
