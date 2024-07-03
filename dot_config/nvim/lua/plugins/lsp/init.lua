return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"yioneko/nvim-vtsls",

			-- Useful status updates for LSP
			-- { "j-hui/fidget.nvim", tag = "v1.4.5" },

			-- LSP linting/formatting etc.
			-- "nvimtools/none-ls.nvim",

			-- Autocompletion
			{
				"hrsh7th/nvim-cmp",
				dependencies = {
					{
						"hrsh7th/cmp-nvim-lsp",
						"hrsh7th/cmp-path",
						"L3MON4D3/LuaSnip",
						"FelipeLema/cmp-async-path",
						{
							"saadparwaiz1/cmp_luasnip",
							config = function()
								require("luasnip.loaders.from_snipmate").lazy_load({ paths = "~/.vim/snippets" })
							end,
						},
					},
				},
			},
		},

		config = function()
			local mappings = require("plugins.lsp.mappings")

			-- LSP settings.
			--  This function gets run when an LSP connects to a particular buffer.
			local on_attach = function(client)
				mappings.init_lsp()
				vim.lsp.inlay_hint.enable(true)
			end

			local servers = require("plugins.lsp.servers")

			-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			-- Setup mason so it can manage external tooling
			require("mason").setup()

			-- Ensure the servers above are installed
			local mason_lspconfig = require("mason-lspconfig")

			mason_lspconfig.setup({
				ensure_installed = vim.tbl_keys(servers),
			})

			mason_lspconfig.setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = servers[server_name],
					})
				end,
			})

			require("lspconfig.configs").vtsls = require("vtsls").lspconfig -- set default server config, optional but recommended

			-- Turn on lsp status information
			-- require("fidget").setup()

			require("plugins.lsp.cmp").init()

			-------------
			-- Styling --
			-------------

			local border = {
				{ "╭", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "╮", "FloatBorder" },
				{ "│", "FloatBorder" },
				{ "╯", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "╰", "FloatBorder" },
				{ "│", "FloatBorder" },
			}

			-- To instead override globally
			local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
			function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
				opts = opts or {}
				opts.border = opts.border or border
				return orig_util_open_floating_preview(contents, syntax, opts, ...)
			end

			-- Diagnostics
			vim.diagnostic.config({
				virtual_text = false,
			})
		end,
	},

	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup({})
		end,
	},
}
