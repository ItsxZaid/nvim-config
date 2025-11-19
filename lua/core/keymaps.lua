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
-- Force hjkl muscle memory
-- This block disables arrow keys in Normal Mode and yells at you.
---
local function brutal_hjkl_reminder(key, replacement)
	-- We use vim.notify for a clean, non-blocking popup.
	local msg = string.format("FUCK. Stop mashing <%s>. Use %s.", key, replacement)
	vim.notify(msg, vim.log.levels.ERROR, { title = "Muscle Memory Failure" })

	-- We're also printing to the command line just to be extra loud.
	vim.api.nvim_echo({ { msg, "ErrorMsg" } }, false, {})
end

vim.keymap.set("n", "<Up>", function()
	brutal_hjkl_reminder("Up", "k")
end, { desc = "Don't use this. Use k." })
vim.keymap.set("n", "<Down>", function()
	brutal_hjkl_reminder("Down", "j")
end, { desc = "Don't use this. Use j." })
vim.keymap.set("n", "<Left>", function()
	brutal_hjkl_reminder("Left", "h")
end, { desc = "Don't use this. Use h." })
vim.keymap.set("n", "<Right>", function()
	brutal_hjkl_reminder("Right", "l")
end, { desc = "Don't use this. Use l." })

-- Open new line and stay in Normal Mode
vim.keymap.set("n", "<leader>o", "o<Esc>", { desc = "Open line below (Normal Mode)" })
vim.keymap.set("n", "<leader>O", "O<Esc>", { desc = "Open line above (Normal Mode)" })

---
-- File / Buffer / Quit
---

-- Use <leader>w (write) and <leader>q (quit)
-- We avoid <C-s> and <C-q> as they are used by terminals to
-- pause (XOFF) and resume (XON) output.
vim.keymap.set("n", "<leader>w", "<cmd> w <CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>sn", "<cmd>noautocmd w <CR>", { desc = "Save without auto-formatting" })
vim.keymap.set("n", "<leader>q", "<cmd> q <CR>", { desc = "Quit file" })
vim.keymap.set("n", "<leader>bd", ":Bdelete!<CR>", { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>b", "<cmd> enew <CR>", { desc = "New empty buffer" })

---
-- Faster Navigation
---

-- Move 5 lines at a time with Alt-j / Alt-k
vim.keymap.set("n", "<A-j>", "5j", { desc = "Move down 5 lines" })
vim.keymap.set("n", "<A-k>", "5k", { desc = "Move up 5 lines" })

---
-- Delete (Void)
---

-- THE VOID OPERATOR-- This maps X to "_d, so it works with all motions (Xiw, Xaw, X$)
vim.keymap.set({ "n", "v" }, "X", '"_d', { desc = "Delete to void (cut)" })

-- Make XX work like dd (delete line to void)
vim.keymap.set("n", "XX", '"_dd', { desc = "Delete line to void" })

---
-- Clipboard & Registers
---
-- NOTE: 'vim.o.clipboard = "unnamedplus"' is set in options.lua

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

-- for count-based terminals.
local function toggleterm_cmd(direction)
	-- v:count1 is the "count" you pass (e.g., "2")
	-- If it's 0 or 1, we just run the command
	-- If it's > 1, we prepend the count to the command
	local count = vim.v.count1
	if count > 0 then
		vim.cmd(count .. "ToggleTerm " .. "direction=" .. direction)
	else
		vim.cmd("ToggleTerm " .. "direction=" .. direction)
	end
end

-- Toggle a floating terminal (with count)
vim.keymap.set("n", "<leader>t", function()
	toggleterm_cmd("float")
end, { desc = "Toggle floating terminal [count]" })

-- Toggle a vertical terminal (with count)
vim.keymap.set("n", "<leader>tv", function()
	toggleterm_cmd("vertical")
end, { desc = "Toggle vertical terminal [count]" })

-- Toggle a horizontal terminal (with count)
vim.keymap.set("n", "<leader>th", function()
	toggleterm_cmd("horizontal")
end, { desc = "Toggle horizontal terminal [count]" })

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
-- Plugin: Diagnostics (LSP & Trouble)
---
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic message" })

-- Trouble.nvim keymaps
vim.keymap.set("n", "<leader>xx", function()
	require("trouble").toggle()
end, { desc = "Toggle Trouble list" })
vim.keymap.set("n", "<leader>xw", function()
	require("trouble").toggle("workspace_diagnostics")
end, { desc = "Workspace diagnostics" })
vim.keymap.set("n", "<leader>xd", function()
	require("trouble").toggle("document_diagnostics")
end, { desc = "Document diagnostics" })

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

---
-- Plugin: Debugger (DAP)
---
vim.keymap.set("n", "<leader>b", function()
	require("dap").toggle_breakpoint()
end, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>dc", function()
	require("dap").continue()
end, { desc = "Continue debugger" })
vim.keymap.set("n", "<leader>do", function()
	require("dap").step_over()
end, { desc = "Debug step over" })
vim.keymap.set("n", "<leader>di", function()
	require("dap").step_into()
end, { desc = "Debug step into" })
vim.keymap.set("n", "<leader>du", function()
	require("dap").step_out()
end, { desc = "Debug step out" })
vim.keymap.set("n", "<leader>dx", function()
	require("dap").terminate()
end, { desc = "Stop debugger" })
vim.keymap.set("n", "<leader>dr", function()
	require("dap").repl.open()
end, { desc = "Open debug REPL" })
vim.keymap.set("n", "<leader>dl", function()
	require("dap").run_last()
end, { desc = "Run last debug" })
vim.keymap.set("n", "<leader>dui", function()
	require("dapui").toggle()
end, { desc = "Toggle DAP UI" })

---
-- Plugin: Neotest
---
vim.keymap.set("n", "<leader>tr", function()
	require("neotest").run.run()
end, { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>tf", function()
	require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Run tests in file" })
vim.keymap.set("n", "<leader>ts", function()
	require("neotest").run.stop()
end, { desc = "Stop nearest test" })

vim.keymap.set("n", "<leader>to", function()
	require("neotest").output.open({ enter = true })
end, { desc = "Show test output" })

---
-- Plugin: Notifications
---
vim.keymap.set("n", "<leader>n", "<cmd>Telescope notify<CR>", { desc = "Show notification history" })
