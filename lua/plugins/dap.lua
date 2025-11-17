return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			-- A UI for the debugger
			{
				"rcarriga/nvim-dap-ui",
				dependencies = { "nvim-neotest/nvim-nio" },
				config = function()
					local dapui = require("dapui")
					dapui.setup({
						layouts = {
							{
								elements = {
									{ id = "scopes", size = 0.25 },
									{ id = "breakpoints", size = 0.25 },
									{ id = "stacks", size = 0.25 },
									{ id = "watches", size = 0.25 },
								},
								size = 40,
								position = "left",
							},
							{
								elements = {
									{ id = "repl", size = 0.5 },
									{ id = "console", size = 0.5 },
								},
								size = 10,
								position = "bottom",
							},
						},
						controls = {
							enabled = true,
							element = "repl",
						},
					})

					-- Hide DAP-UI when the debugger stops
					require("dap").listeners.after.event_terminated["dapui_config"] = function()
						dapui.close()
					end
					require("dap").listeners.before.event_exited["dapui_config"] = function()
						dapui.close()
					end
				end,
			},

			-- Go Adapter
			{ "leoluz/nvim-dap-go" },
		},
		config = function()
			-- This sets up the Go adapter
			require("dap-go").setup()
		end,
	},
}
