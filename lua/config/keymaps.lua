--* [[ Map leader to Space ]]
vim.g.mapleader = " "

--* [[ Map jj to Esc ]]
vim.keymap.set("i", "jj", "<ESC>", { silent = true })

--* [[ Move Lines Up & Down ]]
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", {
  desc = "Move line down",
})
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", {
  desc = "Move line up",
})
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", {
  desc = "Move selection down",
})
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", {
  desc = "Move selection up",
})

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

-- Yank/Delete QOL
vim.keymap.set("x", "p", [["_dP]], { desc = "Paste over selection without losing yanked text" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })
vim.keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clear search highlighting", silent = true })

-- Indentation QOL
vim.keymap.set("v", "<", "<gv", { desc = "Unindent and keep selection" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent and keep selection" })

-- vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines without moving cursor" })

-- Scroll/Search with Cursor at the center of the page
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result cursor centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result cursor centered" })

-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word cursor is on globally" })

-- vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true, desc = "makes file executable" })

-- native undotree
-- vim.keymap.set("n", "<leader>u", function()
--     vim.cmd.packadd("nvim.undotree")
--     require("undotree").open()
-- end, { desc = "Toggle Builtin Undotree" })

-- ? [[ Plugin Keymaps ]]

-- Completion keymaps (mini.completion)
local function pumvisible()
  return vim.fn.pumvisible() ~= 0
end

vim.keymap.set("i", "<CR>", function()
  if pumvisible() then
    if vim.fn.complete_info()["selected"] ~= -1 then
      return "<C-y>"
    end
  end
  return "<CR>"
end, { expr = true, replace_keycodes = true, desc = "Confirm completion" })

vim.keymap.set("i", "<Tab>", function()
  return pumvisible() and "<C-n>" or "<Tab>"
end, { expr = true, replace_keycodes = true, desc = "Next completion item" })

vim.keymap.set("i", "<S-Tab>", function()
  return pumvisible() and "<C-p>" or "<S-Tab>"
end, { expr = true, replace_keycodes = true, desc = "Previous completion item" })
