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

--! [[ Open the file under the cursor ]]
local function open_file_under_cursor()
  local word = vim.fn.expand("<cfile>")
  if vim.fn.filereadable(word) == 1 then
    vim.cmd("edit " .. word)
  else
    print("File not found: " .. word)
  end
end
vim.api.nvim_set_keymap("n", "gF", "<cmd>lua open_file_under_cursor()<CR>", { noremap = true, silent = true })


--! [[ Code Folding ]]
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldlevel = 99
-- vim.o.foldlevelstart = 1
vim.opt.foldtext = ""
-- vim.opt.foldnestmax = 4
-- vim.cmd([[ set nofoldenable]]) -- vim.opt.nofoldenable = true

--? [[ Show Alpha on Empty Buffer ]]
vim.api.nvim_create_augroup("alpha_on_empty", { clear = true })
vim.api.nvim_create_autocmd(
  "BufDelete",
  {
    pattern = "",
    group = "alpha_on_empty",
    callback = function(args)
      local buffers = vim.api.nvim_list_bufs()
      local user_buffers = {}

      for _, buf in ipairs(buffers) do
        -- Only consider listed buffers that are normal files
        if vim.api.nvim_buf_get_option(buf, 'buflisted') and
           vim.api.nvim_buf_get_option(buf, 'buftype') == "" then
          table.insert(user_buffers, buf)
        end
      end
      -- print(#user_buffers) -- Print the count of user buffers
      if #user_buffers == 1 then  -- Check If there is only one user buffer and if its empty
        if buffer_name == "" then
          vim.defer_fn(function()
            vim.cmd("Alpha")
          end, 50)
        end
      end
    end,
  }
)

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
