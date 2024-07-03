local cmpMod = {}

-- Initialize cmp autocompletion setup
function cmpMod.init()
	local cmp = require("cmp")
	local luasnip = require("luasnip")

	completionIcons = {
		Class = " ",
		Color = " ",
		Constant = " ",
		Constructor = " ",
		Enum = "了 ",
		EnumMember = " ",
		Field = " ",
		File = " ",
		Folder = " ",
		Function = " ",
		Interface = "ﰮ ",
		Keyword = " ",
		Method = "ƒ ",
		Module = " ",
		Property = " ",
		Snippet = "﬌ ",
		Struct = " ",
		Text = " ",
		Unit = " ",
		Value = " ",
		Variable = " ",
	}

	cmp.setup({
		window = {
			-- documentation = cmp.config.window.bordered({}),
			completion = cmp.config.window.bordered(),
		},
		completion = {
			keyword_length = 2,
		},
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		performance = {
			max_view_entries = 20,
			debounce = 300,
		},
		formatting = {
			format = function(_, vim_item)
				vim_item.kind = (completionIcons[vim_item.kind] or "") .. vim_item.kind
				return vim_item
			end,
		},
		mapping = cmp.mapping.preset.insert({
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<CR>"] = function(fallback)
				if cmp.visible() then
					cmp.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					})
				else
					fallback()
				end
			end,
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		}),
		sources = {
			{ name = "async_path" },
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "codeium" },
		},
	})
end

return cmpMod
