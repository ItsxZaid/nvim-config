return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	lazy = false,
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			window = {
				position = "left",
				width = 40,
				mappings = {
					["1"] = function()
						require("neo-tree.command").execute({ source = "filesystem", toggle = true })
					end,
					["2"] = function()
						require("neo-tree.command").execute({ source = "buffers", toggle = true })
					end,
					["3"] = function()
						require("neo-tree.command").execute({ source = "git_status", toggle = true })
					end,

					["<CR>"] = "open",
					["o"] = "open",
					["s"] = "open_vsplit",
					["v"] = "open_vsplit",
					["S"] = "open_split",
					["<C-x>"] = "open_split",
					["C"] = "close_node",
					["X"] = "close_all_nodes",
					["z"] = "close_all_nodes",
					["a"] = "add",
					["d"] = "delete",
					["r"] = "rename",
					["y"] = "copy_to_clipboard",
					["x"] = "cut_to_clipboard",
					["p"] = "paste_from_clipboard",
					["?"] = "show_help",
					["q"] = "close_window",
				},
			},
			filesystem = {
				hijack_netrw_behavior = "open_current",
				follow_current_file = {
					enabled = true,
					leave_dirs_open = true,
				},
			},
			diagnostics = {
				sources = { "git", "diagnostic" },
			},
			source_selector = {
				winbar = true,
				sources = {
					{ source = "filesystem" },
					{ source = "buffers" },
					{ source = "git_status" },
					{ source = "diagnostics" },
				},
			},
			default_component_configs = {
				indent = {
					with_expanders = true,
					expander_collapsed = "▸",
					expander_expanded = "▾",
					expander_highlight = "NeoTreeExpander",
				},
				icon = {
					default = "",
					folder_closed = "",
					folder_open = "",
				},
				git_status = {
					symbols = {
						added = "",
						modified = "",
						deleted = "",
						renamed = "Rename",
						untracked = "",
						ignored = "",
						conflicted = "",
					},
				},
			},
		})

		-- Auto-refresh git status when leaving lazygit
		local augroup = vim.api.nvim_create_augroup("NeoTreeGitRefresh", { clear = true })
		vim.api.nvim_create_autocmd({ "BufLeave" }, {
			group = augroup,
			pattern = "lazygit",
			callback = function()
				local events = require("neo-tree.events")
				events.fire_event(events.GIT_EVENT)
			end,
		})
	end,
}
