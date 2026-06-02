--! [[ Disable netrw ]]
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--! [[ Enable 24-bit colour ]]
vim.opt.termguicolors = true

--! [[ Line Numbers ]]
vim.opt.nu = true
vim.opt.relativenumber = true

--! [[ Current Cursor Line Color ]]
vim.opt.cursorline = true

--! [[ Word Wrap ]]
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.showbreak = "↪ "

--! [[ Spaces/Tabs ]]
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

--! [[ Disable AutoFormatting ]]
vim.g.autoformat = false

--! [[ Splits ]]
vim.opt.splitbelow = true
vim.opt.splitright = true

--! [[ Search ]]
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.laststatus = 3

--! [[ Swap/Undo ]]
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true

--! [[ Autocompletion ]]
vim.opt.completeopt = "menuone,noselect,fuzzy,nosort"
vim.opt.shortmess:append("c")
vim.opt.clipboard:append("unnamedplus")
vim.opt.isfname:append("@-@")
vim.opt.guicursor = ""
vim.opt.scrolloff = 8

--! [[ Column Line ]]
vim.opt.colorcolumn = "0"
vim.opt.signcolumn = "yes"

--! [[ Yank Highlighting ]]
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  callback = function()
    vim.hl.on_yank()
  end,
})
