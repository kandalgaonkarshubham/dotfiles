-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

--* [[ Map jj to Esc ]]
vim.keymap.set("i", "jj", "<ESC>", { silent = true })

--* Move Lines Up & Down
-- vim.api.nvim_set_keymap('n', 'J', ":m .+1<CR>==", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', 'K', ":m .-2<CR>==", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })


--* [[ Function to open a file in a floating window ]]
local function open_floating_window(file_path)
	-- Create a new buffer
	local buf = vim.api.nvim_create_buf(false, true) -- No file, buffer is scratch

	-- Set the floating window dimensions
	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	-- Create the floating window
	vim.api.nvim_open_win(buf, true, {
		relative = 'editor',
		width = width,
		height = height,
		row = row,
		col = col,
		style = 'minimal',
		border = 'rounded', -- Optional: 'single', 'double', 'solid', or 'none'
	})

	-- Load the file into the buffer
	vim.api.nvim_buf_set_option(buf, 'modifiable', true)
	vim.cmd('edit ' .. file_path)

	-- Check the file extension
	local ext = file_path:match("^.+(%..+)$")
	if ext == ".md" then
		-- Enable Markdown syntax highlighting
		vim.cmd('set filetype=markdown')
	end

	-- Make the buffer non-modifiable
	vim.api.nvim_buf_set_option(buf, 'modifiable', false)
end
--? Key mapping to open Commit Conventions
vim.keymap.set('n', '<leader>tc', function()
	open_floating_window(vim.fn.expand('~/Projects/COMMIT-CONVENTIONS.md'))
end, { noremap = true, silent = true, desc = "[c]ommit conventions" })
