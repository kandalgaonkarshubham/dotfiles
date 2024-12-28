--! [[ NeoVim Startup Optimization]]
vim.loader.enable()

--! [[ File Encoding ]]
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.fileencoding = "utf-8"

--! [[ Leader ]]
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--! [[ Line Numbers ]]
vim.opt.number = true
vim.opt.relativenumber = true

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

--! [[ Code Folding ]]
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldcolumn = '0'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.opt.foldtext = ""
vim.o.foldenable = true
-- vim.opt.foldnestmax = 4
-- vim.cmd([[ set nofoldenable]]) -- vim.opt.nofoldenable = true

--! [[ For nvim-notify ]]
vim.opt.termguicolors = true

--! [[ Current Cursor Line Color ]]
vim.opt.cursorline = true

--! [[ Map jj to Esc ]]
vim.keymap.set("i", "jj", "<ESC>", { silent = true })
--! [[ Map oo to Ctrl+o ]]
vim.keymap.set('i', 'oo', '<C-o>', { silent = true })


--? [[ Replace ~ ]]
vim.opt.fillchars = { eob = " " }

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

--? [[ Function to open a file in a floating window ]]
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
vim.keymap.set('n', '<leader>oc', function()
  open_floating_window(vim.fn.expand('~/Projects/COMMIT-CONVENTIONS.md'))
end, { noremap = true, silent = true, desc = "[c]ommit conventions" })


--* Re-open at last position
vim.cmd [[ au BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]]

--* Move Lines Up & Down
-- vim.api.nvim_set_keymap('n', 'J', ":m .+1<CR>==", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', 'K', ":m .-2<CR>==", { noremap = true, silent = true })
-- Move line down
vim.api.nvim_set_keymap('n', 'J', ":m .+1<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'K', ":m .-2<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
