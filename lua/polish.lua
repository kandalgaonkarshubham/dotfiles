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

--? Automatically open alpha when the last buffer is deleted and only one window left
  -- Create autocommand group for handling empty buffer scenarios
local alpha_on_empty = vim.api.nvim_create_augroup("alpha_on_empty", { clear = true })

vim.api.nvim_create_autocmd("BufDelete", {
  group = alpha_on_empty,
  callback = function(event)
    -- Get list of all listed buffers
    local buffers = vim.fn.getbufinfo({ buflisted = true })

    -- If no more listed buffers remain, show the Alpha dashboard
    if #buffers == 1 then  -- Use 1 because we are in the process of closing a buffer
      -- Close Neo-tree if it's open
      pcall(function() require("neo-tree").close_all() end)

      -- Wipe out the last buffer and open the Alpha dashboard
      vim.cmd(event.buf .. "bwipeout")
      vim.cmd("Alpha")
    end
  end,
})

--? Move Lines Up & Down
-- vim.api.nvim_set_keymap('n', 'K', ":m .+1<CR>==", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', 'J', ":m .-2<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', 'J', "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', 'K', "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
