return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-go", -- Adapter for Go
		"nvim-neotest/nvim-nio",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-go")({
					-- Add any Go-specific test config here
				}),
			},
		})
	end,
}
