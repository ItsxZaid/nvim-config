return {
	"rcarriga/nvim-notify",
	config = function()
		local notify = require("notify")

		notify.setup({
			renderer = "default",
			stages = "fade_in_slide_out",
			timeout = 3000,
		})

		-- Override the default notifier
		vim.notify = notify
	end,
}
