return {
	"ahmedkhalf/project.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("project_nvim").setup({
			patterns = {
				".git",
				"_darcs",
				".hg",
				".bzr",
				".svn",
				"Makefile",
				"package.json",
				"go.mod",
			},

			manual_mode = false,

			datapath = vim.fn.stdpath("data") .. "/project_nvim/",

			-- IMPORTANT: Change '~/Projects' and '~/Code' to wherever you
			--            actually store your code.
			scan_hidden = false,
			search_dirs = {
				"~/Projects",
				"~/Code",
				"~/dev",
				"~/Documents",
			},
		})

		require("telescope").load_extension("projects")
	end,
}
