-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Navigate buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", ":Bdelete<CR>", { desc = "Delete buffer" })

-- Press jk fast to enter
vim.keymap.set("i", "jk", "<ESC>")
-- removes the ^M when we copy from windows system to linux
vim.keymap.set("n", "<Leader>m", ":%s/\r$//g")

vim.keymap.set("n", "gh", function()
	local line = vim.api.nvim_win_get_cursor(0)[1] - 1
	local diagnostics = vim.diagnostic.get(0, { lnum = line })

	if #diagnostics > 0 then
		vim.diagnostic.open_float(nil, { scope = "cursor", focus = false, source = "if_many" })
	else
		vim.lsp.buf.hover()
	end
end, { desc = "Hover or line diagnostics" })

local function terminal_bottom()
	Snacks.terminal(nil, {
		cwd = LazyVim.root(),
		win = { position = "bottom" },
	})
end

local function terminal_popup()
	Snacks.terminal(nil, {
		cwd = LazyVim.root(),
		win = { position = "float" },
	})
end

vim.keymap.set({ "n", "i", "t" }, "<C-`>", terminal_bottom, { desc = "Terminal (bottom root dir)" })
vim.keymap.set({ "n", "i", "t" }, "<C-~>", terminal_bottom, { desc = "which_key_ignore" })
vim.keymap.set({ "n", "i", "t" }, "<C-/>", terminal_bottom, { desc = "which_key_ignore" })
vim.keymap.set({ "n", "i", "t" }, "<C-_>", terminal_bottom, { desc = "which_key_ignore" })

vim.keymap.set("n", "<leader>t", terminal_popup, { desc = "Terminal (popup root dir)" })
vim.keymap.set("n", "<leader>+t", terminal_popup, { desc = "which_key_ignore" })

-- Navigate vim pane better
-- vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
-- vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
-- vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
-- vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- Set keymaps to control the debugger
vim.keymap.set("n", "<F5>", require("dap").continue)
vim.keymap.set("n", "<F10>", require("dap").step_over)
vim.keymap.set("n", "<F11>", require("dap").step_into)
vim.keymap.set("n", "<F12>", require("dap").step_out)
vim.keymap.set("n", "<leader>b", require("dap").toggle_breakpoint)
vim.keymap.set("n", "<leader>B", function()
	require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)
