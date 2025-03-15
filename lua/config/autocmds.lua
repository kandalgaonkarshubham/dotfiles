-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Lazyvim's highlight on word
vim.api.nvim_create_autocmd("BufRead", {
  callback = function()
    vim.api.nvim_set_hl(0, "LspReferenceText", {})
    vim.api.nvim_set_hl(0, "LspReferenceRead", {})
    vim.api.nvim_set_hl(0, "LspReferenceWrite", {})
  end,
})

--? [[ Show Alpha on Empty Buffer ]]
-- vim.api.nvim_create_augroup("dashboard_on_empty", { clear = true })
-- vim.api.nvim_create_autocmd("BufDelete", {
--   pattern = "",
--   group = "dashboard_on_empty",
--   callback = function(args)
--     local buffers = vim.api.nvim_list_bufs()
--     local user_buffers = {}
--
--     for _, buf in ipairs(buffers) do
--       -- Only consider listed buffers that are normal files
--       if vim.api.nvim_buf_get_option(buf, "buflisted") and vim.api.nvim_buf_get_option(buf, "buftype") == "" then
--         table.insert(user_buffers, buf)
--       end
--     end
--     -- print(#user_buffers) -- Print the count of user buffers
--     if #user_buffers == 1 then -- Check If there is only one user buffer and if its empty
--       if buffer_name == "" then
--         vim.defer_fn(function()
--           vim.cmd("Alpha")
--         end, 50)
--       end
--     end
--   end,
-- })

--* [[ MACROS ]]

-- ? [[ Console.log ]]

local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)
vim.fn.setreg("l", "yoconsole.log('" .. esc .. "pa:" .. esc .. "la, " .. esc .. "pl")
