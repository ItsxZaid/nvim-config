return {
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = " " },
					topdelete = { text = "‾" },
					changedelete = { text = "│" },
					untracked = { text = "│" },
				},
				signcolumn = true,
				numhl = false,
				on_attach = function()
					local gs = require("gitsigns")
					-- Navigation
					vim.keymap.set("n", "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true, desc = "Next hunk" })

					vim.keymap.set("n", "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true, desc = "Previous hunk" })

					-- Actions
					vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
					vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
					vim.keymap.set("v", "<leader>hs", function()
						gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Stage selected" })
					vim.keymap.set("v", "<leader>hr", function()
						gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Reset selected" })
					vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
					vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
					vim.keymap.set("n", "<leader>hb", gs.blame_line, { desc = "Git blame line" })
				end,
			})
		end,
	},

	{
		"kdheepak/lazygit.nvim",
		cmd = "LazyGit",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
}
