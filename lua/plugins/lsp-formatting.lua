return {
	{
		"stevearc/conform.nvim",
		opts = {
			-- "stylua" is for Lua.
			formatters_by_ft = {
				lua = { "stylua" },

				-- Web
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				markdown = { "prettier" },
				svelte = { "prettier" },
				-- Go
				go = { "gofumpt" },
			},

			format_on_save = {
				-- This timeout is for the LSP.
				-- We give it 1 second to format before we time out.
				timeout_ms = 1000,
				-- This tells conform to use the LSP as a formatter.
				lsp_fallback = true,
			},
		},
	},
}
