return {
	settings = {
		Lua = {
			hint = { enable = true },
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
}
