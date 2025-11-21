require("core.options")
require("core.keymaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require("lazy").setup({
	require("plugins.lsp-mason"),
	require("plugins.lsp-completion"),
	require("plugins.lsp-formatting"),
	require("plugins.lsp-snippets"),
	require("plugins.neotree"),
	require("plugins.theme"),
	require("plugins.terminal"),

	require("plugins.notify"),

	require("plugins.project"),

	require("plugins.session"),
	require("plugins.which-key"),
	require("plugins.telescope"),
	require("plugins.git"),

	require("plugins.smear-cursor"),

	require("plugins.treesitter"),
	require("plugins.ui-extras"),
	require("plugins.editing-extras"),

	-- :Bdelete command support plugin
	"famiu/bufdelete.nvim",

	require("plugins.dap"),
	require("plugins.trouble"),
	require("plugins.testing"),

	-- Discord rich presence to show "i use Neovim btw"
	require("plugins.cord"),
})
