-- This file contains all of our keymaps.
-- We add a 'desc' field to each one to make them searchable.

-- Set leader key
-- MUST be done before plugins are loaded (e.g., before lazy.setup)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- For conciseness in defining maps
local opts = { noremap = true, silent = true }

---
-- General & Navigation
---

-- Disable the spacebar key's default behavior
-- We want to use Space as our leader key, so we prevent it from
-- doing its default (moving cursor right) in Normal/Visual mode.
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Allow moving the cursor through wrapped lines with j, k
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Clear search highlights
vim.keymap.set("n", "<Esc>", "<cmd> noh <CR>", { desc = "Clear search highlights" })

-- Vertical scroll and center (keeps cursor in middle of screen)
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- Find and center (keeps search result in middle of screen)
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

---
-- File / Buffer / Quit
---

-- Use <leader>w (write) and <leader>q (quit)
-- We avoid <C-s> and <C-q> as they are used by terminals to
-- pause (XOFF) and resume (XON) output.
vim.keymap.set("n", "<leader>w", "<cmd> w <CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>sn", "<cmd>noautocmd w <CR>", { desc = "Save without auto-formatting" })
vim.keymap.set("n", "<leader>q", "<cmd> q <CR>", { desc = "Quit file" })
vim.keymap.set("n", "<leader>x", ":Bdelete!<CR>", { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>b", "<cmd> enew <CR>", { desc = "New empty buffer" })

---
-- Clipboard & Registers
---
-- NOTE: 'vim.o.clipboard = "unnamedplus"' is set in options.lua

-- Copy selected characters in Visual mode to system clipboard
vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })

-- Delete single character without copying into register
vim.keymap.set("n", "x", '"_x', { desc = "Delete character" })

-- Explicitly yank to system clipboard (highlighted and entire row)
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

-- Keep last yanked item when pasting over a selection
vim.keymap.set("v", "p", '"_dP', { desc = "Paste without losing yank" })

---
-- Window Management (Splits & Tabs)
---

-- Window Splits
vim.keymap.set("n", "<leader>v", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>s", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" })
vim.keymap.set("n", "<leader>c", ":close<CR>", { desc = "Close current split" })

-- Navigate between splits
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", { desc = "Navigate to split above" })
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", { desc = "Navigate to split below" })
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", { desc = "Navigate to split left" })
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", { desc = "Navigate to split right" })

-- Resize splits using Ctrl + Arrow Keys (more ergonomic)
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", { desc = "Decrease split height" })
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", { desc = "Increase split height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease split width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase split width" })

-- Buffers (already open files)
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<C-i>", "<C-i>", opts) -- to restore jump forward

-- Tabs
-- We use <leader>T (uppercase) for Tabs to avoid conflict with <leader>t (terminal)
vim.keymap.set("n", "<leader>To", ":tabnew<CR>", { desc = "Open new tab" })
vim.keymap.set("n", "<leader>Tx", ":tabclose<CR>", { desc = "Close current tab" })
vim.keymap.set("n", "<leader>Tn", ":tabn<CR>", { desc = "Go to next tab" })
vim.keymap.set("n", "<leader>Tp", ":tabp<CR>", { desc = "Go to previous tab" })

---
-- Plugin: Neotree
---

-- Toggle file explorer (changed from <C-b> to avoid tmux conflict)
vim.keymap.set("n", "<leader>e", "<cmd> Neotree toggle <CR>", { desc = "Toggle file explorer" })

---
-- Plugin: Terminals (from toggleterm.nvim)
---

-- Toggle a floating terminal
vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm direction=float<CR>", { desc = "Toggle floating terminal" })

-- Toggle a vertical terminal
vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "Toggle vertical terminal" })

-- Toggle a horizontal terminal
vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Toggle horizontal terminal" })

-- Exit terminal insert mode with <Esc>
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

---
-- Plugin: Telescope (Fuzzy Finder)
---
-- We call require() *inside* the function so it's guaranteed to be loaded.
vim.keymap.set("n", "<leader>ff", function()
	require("telescope.builtin").find_files()
end, { desc = "Find files" })

vim.keymap.set("n", "<leader>fg", function()
	require("telescope.builtin").live_grep()
end, { desc = "Find text (grep)" })

vim.keymap.set("n", "<leader>fb", function()
	require("telescope.builtin").buffers()
end, { desc = "Find open buffers" })

vim.keymap.set("n", "<leader>fr", function()
	require("telescope.builtin").oldfiles()
end, { desc = "Find recent files (Oldfiles)" })

vim.keymap.set("n", "<leader>fp", function()
	require("telescope").extensions.projects.projects()
end, { desc = "Find projects" })

vim.keymap.set("n", "<leader>fh", function()
	require("telescope.builtin").help_tags()
end, { desc = "Find help tags" })

---
-- Plugin: Lazygit
---
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "Open Lazygit" })

---
-- Plugin: Comment.nvim
---
-- This adds the "toggle comment" keymap.
-- I'm using <leader>/ which is a common and easy-to-remember key.
vim.keymap.set("n", "<leader>/", function()
	require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment" })

vim.keymap.set("v", "<leader>/", function()
	-- In visual mode, we toggle the selected lines
	require("Comment.api").toggle.linewise(vim.fn.visualmode())
end, { desc = "Toggle comment (visual)" })

---
-- Plugin: Diagnostics (LSP)
---
-- These are the *original* diagnostic maps from your file.
-- We keep these here for now. When we install the LSP,
-- we will move these to a better spot.
local diagnostics_active = true
vim.keymap.set("n", "<leader>do", function()
	diagnostics_active = not diagnostics_active
	if diagnostics_active then
		vim.diagnostic.enable(true)
	else
		vim.diagnostic.enable(false)
	end
end, { desc = "Toggle diagnostics" })

-- Diagnostic navigation
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous diagnostic" })

vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next diagnostic" })

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic message" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

---
-- Editor & Code
---

-- Press jk fast to exit insert mode
vim.keymap.set("i", "jk", "<ESC>", opts)
vim.keymap.set("i", "kj", "<ESC>", opts)

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Move text up and down
vim.keymap.set("v", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })

-- Increment/decrement numbers
vim.keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
vim.keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Replace word under cursor
vim.keymap.set("n", "<leader>r", "*``cgn", { desc = "Replace word under cursor" })

-- Toggle line wrapping
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", { desc = "Toggle line wrap" })

---
-- Session Management
---

-- Save and load session
vim.keymap.set("n", "<leader>ss", ":mksession! .session.vim<CR>", { silent = false, desc = "Save session" })
vim.keymap.set("n", "<leader>sl", ":source .session.vim<CR>", { silent = false, desc = "Load session" })
