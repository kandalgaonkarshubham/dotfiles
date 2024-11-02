--! [[ File Encoding ]]
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.fileencoding = "utf-8"

--! [[ Leader ]]
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--! [[ Line Numbers ]]
vim.opt.number = true

--! [[ Line Wrap ]]
vim.opt.wrap = true
vim.opt.breakindent = true

--! [[ Search ]]
vim.opt.hlsearch = true

--! [[ Indentation ]]
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

--! [[ Enable/Disable Mouse ]]
vim.opt.mouse = ""

--! [[ Allows backspacing over Indentation, Line endings, Start of Insert Mode (i.e. the first character on the line) ]]
vim.opt.backspace = { "indent", "eol", "start" }

--! [[ Path & Ignore Directories ]]
vim.opt.path:append({ "**" })
vim.opt.wildignore:append({ "*/node_modules/*" })

--! [[ Automatically insert comments when hitting Enter while typing in a comment ]]
vim.opt.formatoptions:append({ "r" })

--! [[ Sync System Clipboard ]]
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

--! [[ Persistent Undo ]]
vim.opt.undofile = true

--! [[ Screen lines to keep Above & Below the cursor when scrolling ]]
vim.opt.scrolloff = 10

--! [[ Keymappings Timeouts ]]
vim.opt.timeoutlen = 300

--! [[ Nerd Font ]]
vim.g.have_nerd_font = true


--? [[ Show Alpha on Empty Buffer ]]
-- vim.api.nvim_create_augroup("alpha_on_empty", { clear = true })
-- vim.api.nvim_create_autocmd("User", {
-- 	pattern = "BDeletePre *",
-- 	group = "alpha_on_empty",
-- 	callback = function()
-- 		local bufnr = vim.api.nvim_get_current_buf()
-- 		local name = vim.api.nvim_buf_get_name(bufnr)

-- 		if name == "" then
--       vim.cmd([[:Alpha | bd#]])
-- 		end
-- 	end,
-- })

-- vim.api.nvim_create_autocmd("User", {

--   -- stuff....

--   callback = function()
--     if fallback_on_empty then
--       local ok, _ = pcall(require, "neo-tree")

--       if not ok then
--         vim.cmd("packadd neo-tree")
--         -- Use the latest recommended approach to handle Neotree. See the docs for info:
--         -- https://github.com/nvim-neo-tree/neo-tree.nvim/blob/ab8ca9fac52949d7a741b538c5d9c3898cd0f45a/doc/neo-tree.txt#L140
--         vim.cmd("Neotree close")
--       end

--       vim.cmd("Alpha")
--       vim.cmd(event.buf .. "bwipeout")
--     end
--   end,
-- })

--? [[ Replace ~ in Alpha ]]
vim.api.nvim_create_autocmd("FileType", {
  pattern = "alpha",
  callback = function()
    vim.opt_local.fillchars:append { eob = " " }
  end,
})

--* Re-open at last position
vim.cmd [[ au BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]]

--* Shift buffers
vim.api.nvim_set_keymap('n', '<S-Tab>', ':bnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<S-Tab>', ':bnext<CR>', { noremap = true, silent = true })

--* Move Lines Up & Down
vim.api.nvim_set_keymap('n', 'K', ":m .+1<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'J', ":m .-2<CR>==", { noremap = true, silent = true })

--* Keymap to close the current buffer
vim.api.nvim_set_keymap("n", "<leader>c", ":bd<CR>", { noremap = true, silent = true })
