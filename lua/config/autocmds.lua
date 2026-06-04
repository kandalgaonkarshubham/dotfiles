--? [[ MasonUpdateAllComplete ]]
vim.api.nvim_create_autocmd('User', {
  pattern = 'MasonUpdateAllComplete',
  callback = function()
    print('mason-update-all has finished')
  end,
})

--? [[ Disable autoformat for specific directories ]]
-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--   callback = function()
--     local cwd = vim.fn.getcwd()
--     -- print("Current working directory: " .. cwd)

--     local disabled_dirs = {
--       "/home/tazerblaze/Projects/wntp",
--     }
--     for _, dir in ipairs(disabled_dirs) do
--       if cwd:find(vim.fn.expand(dir)) == 1 then
--         vim.b.autoformat = false
--         -- print("Autoformat is disabled for this directory.")
--         break
--       end
--     end
--   end,
-- })

--? [[ Lsp Autocomplete ]]
-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(ev)
--     local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
--     if client:supports_method('textDocument/completion') then
--       vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
--     end
--   end,
-- })
-- vim.opt.complete:append('o')
