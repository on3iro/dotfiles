return {
	"mfussenegger/nvim-dap",
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			local dapui = require("dapui")
			dapui.setup()

			vim.api.nvim_set_keymap(
				"n",
				"<leader>db",
				":lua require('dapui').toggle()<cr>",
				{ noremap = true, desc = "[Debug] Toggle UI" }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>br",
				":lua require('dap').toggle_breakpoint()<cr>",
				{ noremap = true, desc = "[Debug] Set breakpoint" }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>ct",
				":lua require('dap').continue()<cr>",
				{ noremap = true, desc = "[Debug] Continue" }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>st",
				":lua require('dap').step_into()<cr>",
				{ noremap = true, desc = "[Debug] Step into" }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>so",
				":lua require('dap').step_over()<cr>",
				{ noremap = true, desc = "[Debug] Continue" }
			)
		end,
	},
}
