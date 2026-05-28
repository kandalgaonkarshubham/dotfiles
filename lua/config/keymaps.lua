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

--* [[ Save File ]]
vim.keymap.set("n", "<leader>bs", ":w<CR>", { noremap = true, silent = true, desc = "Save Buffer" })

-- ? [[ Console.log ]]
local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)
-- Visual mode: wraps selection in console.log(...)
vim.keymap.set("v", "<leader>cl", function()
  vim.cmd.normal("y") -- yank selection
  vim.cmd.normal("oconsole.log('" .. esc .. "pa:', " .. esc .. "pA);" .. esc)
end, { desc = "Console log selected text" })

-- Normal mode: wraps word under cursor in console.log(...)
vim.keymap.set("n", "<leader>cl", function()
  vim.cmd.normal("yiw") -- yank inner word
  vim.cmd.normal("oconsole.log('" .. esc .. "pa:', " .. esc .. "pA);" .. esc)
end, { desc = "Console log word under cursor" })


-- ? [[ Plugin Keymaps ]]
