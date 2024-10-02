-- if true then return end --! WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

--? Set up custom filetypes
vim.filetype.add {
  extension = {
    foo = "fooscript",
  },
  filename = {
    ["Foofile"] = "fooscript",
  },
  pattern = {
    ["~/%.config/foo/.*"] = "fooscript",
  },
}

--? Re-open at last position
vim.cmd [[ au BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]]

--? Shift buffers
vim.api.nvim_set_keymap('n', '<S-Tab>', ':bprev<CR>', { noremap = true })

--? Move Lines Up & Down
-- vim.api.nvim_set_keymap('n', 'K', ":m .+1<CR>==", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', 'J', ":m .-2<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', 'J', "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', 'K', "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

--? Disable arrow keys
vim.api.nvim_set_keymap('n', '<Up>', '<NOP>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Down>', '<NOP>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Left>', '<NOP>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Right>', '<NOP>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('v', '<Up>', '<NOP>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Down>', '<NOP>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Left>', '<NOP>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Right>', '<NOP>', { noremap = true, silent = true })
