-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

--! [[ Current Cursor Line Color ]]
vim.opt.cursorline = true

--! [[ Eslint & Prettier ]]
vim.g.lazyvim_eslint_auto_format = false
vim.g.lazyvim_prettier_needs_config = true

--! [[ Word Wrap ]]
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.showbreak = "↪ "

--! [[ Status Line (For Avante) ]]
vim.opt.laststatus = 3
