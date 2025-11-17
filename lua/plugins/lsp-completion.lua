return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
				mapping = cmp.mapping.preset.insert({
					-- Stop tabbing. Use C-n/C-p. It's faster.
					-- Your hands stay on the home row.
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),

					["jk"] = cmp.mapping.abort(),
					["kj"] = cmp.mapping.abort(),

					-- This is your new "Smart Enter"
					-- If the menu is open, it confirms the highlighted item.
					-- If the menu is closed, it's just a regular Enter.
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = true, -- This is the key. It confirms the selected item.
					}),

					["<C-Space>"] = cmp.mapping.complete(),

					-- This is your new "Smart Tab"
					-- It will do 3 things, in order:
					-- 1. If menu is open, go to the next item.
					-- 2. If on a snippet, jump to the next snippet placeholder.
					-- 3. Otherwise, just be a normal Tab.
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }), -- 'i' for insert mode, 's' for snippet mode

					-- Smart Shift-Tab (goes backwards)
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = require("lspkind").cmp_format({
						with_text = true,
						menu = {
							buffer = "[Buf]",
							nvim_lsp = "[LSP]",
							luasnip = "[Snip]",
							path = "[Path]",
						},
					}),
				},
			})
		end,
	},
	{
		"onsails/lspkind.nvim",
	},
}
