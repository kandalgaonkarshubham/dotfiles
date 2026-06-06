--? [[ MasonUpdateAllComplete ]]
-- vim.api.nvim_create_autocmd('User', {
--   pattern = 'MasonUpdateAllComplete',
--   callback = function()
--     print('mason-update-all has finished')
--   end,
-- })

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

-- restore cursor to file position in previous editing session
-- vim.api.nvim_create_autocmd("BufReadPost", {
-- 	callback = function(args)
-- 		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
-- 		local line_count = vim.api.nvim_buf_line_count(args.buf)
-- 		if mark[1] > 0 and mark[1] <= line_count then
-- 			vim.api.nvim_win_set_cursor(0, mark)
-- 			-- defer centering slightly so it's applied after render
-- 			vim.schedule(function()
-- 				vim.cmd("normal! zz")
-- 			end)
-- 		end
-- 	end,
-- })

-- no auto continue comments on new line
-- vim.api.nvim_create_autocmd("FileType", {
-- 	group = vim.api.nvim_create_augroup("no_auto_comment", {}),
-- 	callback = function()
-- 		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
-- 	end,
-- })

-- syntax highlighting for dotenv files
-- vim.api.nvim_create_autocmd("BufRead", {
-- 	group = vim.api.nvim_create_augroup("dotenv_ft", { clear = true }),
-- 	pattern = { ".env", ".env.*" },
-- 	callback = function()
-- 		vim.bo.filetype = "dosini"
-- 	end,
-- })

-- Update all vim.pack plugins
vim.api.nvim_create_user_command("PackUpdate", function()
	vim.notify("Updating vim.pack plugins...", vim.log.levels.INFO)
	vim.pack.update()
end, {
	desc = "Update all vim.pack plugins",
})

-- Remove plugins that are no longer declared in vim.pack.add()
vim.api.nvim_create_user_command("PackClean", function()
	local inactive = vim.iter(vim.pack.get())
		:filter(function(plugin)
			return not plugin.active
		end)
		:map(function(plugin)
			return plugin.spec.name
		end)
		:totable()

	if #inactive == 0 then
		vim.notify("No inactive plugins to remove", vim.log.levels.INFO)
		return
	end

	vim.pack.del(inactive)

	vim.notify(
		"Removed: " .. table.concat(inactive, ", "),
		vim.log.levels.INFO
	)
end, {
	desc = "Remove plugins not declared in vim.pack.add()",
})

-- Update plugins and remove inactive ones
vim.api.nvim_create_user_command("PackSync", function()
	vim.pack.update()

	local inactive = vim.iter(vim.pack.get())
		:filter(function(plugin)
			return not plugin.active
		end)
		:map(function(plugin)
			return plugin.spec.name
		end)
		:totable()

	if #inactive > 0 then
		vim.pack.del(inactive)
	end
end, {
	desc = "Update plugins and remove inactive ones",
})
