-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
return {
	gopls = {
		["gopls"] = {
			hints = {
				assignVariableTypes = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
		},
	},
	rust_analyzer = {
		["rust-analyzer"] = {
			-- enable clippy on save
			cargo = {
				autoreload = true,
			},
			checkOnSave = {
				command = "clippy",
				enable = true,
			},
			completion = {
				autoimport = {
					enable = true,
				},
			},
			diagnostics = {
				disabled = { "macro-error" },
			},
			procMacro = {
				enable = true,
			},
			updates = {
				channel = "stable",
			},
		},
	},
}