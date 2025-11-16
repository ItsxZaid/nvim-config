return {

	"catppuccin/nvim",

	name = "catppuccin",

	priority = 1000,

	config = function()
		require("catppuccin").setup({

			flavour = "mocha", -- latte, frappe, macchiato, mocha
			transparent_background = true,
			integrations = {

				neotree = true,

				telescope = true,
			},
		})

		-- Load the colorscheme

		vim.cmd.colorscheme("catppuccin")
	end,
}
