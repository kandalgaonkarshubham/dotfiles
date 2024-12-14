-- if true then return {} end --! WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
	--! LSP -------------------------------------------------------------
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"html",
					"cssls",
					"tailwindcss",
					"ts_ls",
					"prismals",
					"jsonls",
					"emmet_language_server",
					"lua_ls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			local servers = { "html", "cssls", "tailwindcss", "prismals", "jsonls", "lua_ls" }
			for _, server in ipairs(servers) do
				lspconfig[server].setup({
					capabilities = capabilities,
				})
				lspconfig.ts_ls.setup({
					capabilities = capabilities,
					init_options = {
						preferences = {
							disableSuggestions = true,
						},
					},
				})
				lspconfig.emmet_language_server.setup({
					capabilities = capabilities,
					filetypes = { "css", "html", "javascript", "javascriptreact", "typescriptreact", "vue" },
				})
			end
			vim.keymap.set(
				"n",
				"<leader>cr",
				vim.lsp.buf.references,
				{ noremap = true, silent = true, desc = "Show [r]eferences" }
			)
			vim.keymap.set(
				"n",
				"<leader>gD",
				vim.lsp.buf.declaration,
				{ noremap = true, silent = true, desc = "[g]o to [D]eclaration" }
			)
			vim.keymap.set(
				"n",
				"<leader>gf",
				vim.lsp.buf.definition,
				{ noremap = true, silent = true, desc = "Go to definition [f]ile" }
			)
			vim.keymap.set(
				"n",
				"<leader>gi",
				vim.lsp.buf.implementation,
				{ noremap = true, silent = true, desc = "[g]o to [i]mplementation" }
			)
			vim.keymap.set(
				"n",
				"<leader>ca",
				vim.lsp.buf.code_action,
				{ noremap = true, silent = true, desc = "[c]ode [a]ctions" }
			)
			vim.keymap.set(
				"n",
				"<leader>cn",
				vim.lsp.buf.rename,
				{ noremap = true, silent = true, desc = "[c]ode re[n]ame symbol" }
			)
			-- vim.keymap.set('n', '<leader>clD', vim.lsp.diagnostic.show_line_diagnostics, { noremap = true, silent = true, desc = '[l]ine [D]iagnostics' })
			-- vim.keymap.set('n', '<leader>cd', vim.lsp.diagnostic.show_cursor_diagnostics, { noremap = true, silent = true, desc = '[c]ursor [d]iagnostics' })
			-- vim.keymap.set('n', '<leader>c[d', vim.lsp.diagnostic.goto_prev, { noremap = true, silent = true, desc = 'Previous diagnostic' })
			-- vim.keymap.set('n', '<leader>c]d', vim.lsp.diagnostic.goto_next, { noremap = true, silent = true, desc = 'Next diagnostic' })
			vim.keymap.set(
				"n",
				"<leader>ch",
				vim.lsp.buf.hover,
				{ noremap = true, silent = true, desc = "[c]ode [h]over documentation" }
			)
		end,
	},
	{
		"schrieveslaach/sonarlint.nvim",
		url = "https://gitlab.com/schrieveslaach/sonarlint.nvim",
		ft = { "html", "php", "javascript", "typescript", "javascriptreact", "typescriptreact" },
		config = function()
			require("sonarlint").setup({
				-- capabilities = require('cmp_nvim_lsp').default_capabilities(),
				server = {
					cmd = {
						"sonarlint-language-server",
						-- Ensure that sonarlint-language-server uses stdio channel
						"-stdio",
						"-analyzers",
						-- paths to the analyzers you need, using those for python and java in this example | ~/.local/share/nvim/mason/share/sonarlint-analyzers
						vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarhtml.jar"),
						vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarphp.jar"),
						vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjs.jar"),
						-- vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
						-- vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcfamily.jar"),
						-- vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
					},
				},
				settings = {
					sonarlint = {
						test = "test",
						rules = {
							["typescript:S101"] = { level = "on", parameters = { format = "^[A-Z][a-zA-Z0-9]*$" } },
							["typescript:S103"] = { level = "on", parameters = { maximumLineLength = 180 } },
							["typescript:S106"] = { level = "on" },
							["typescript:S107"] = { level = "on", parameters = { maximumFunctionParameters = 7 } },
						},
					},
				},
				filetypes = {
					"html",
					"php",
					"javascript",
					"typescript",
					"javascriptreact",
					"typescriptreact",
					-- 'python',
					-- 'cpp',
					-- 'java',
				},
			})
		end,
	},
	--! COMPLETIONS -------------------------------------------------------------
	{
		"hrsh7th/cmp-nvim-lsp",
		event = "BufReadPost",
	},
	{
		"L3MON4D3/LuaSnip",
		event = "BufReadPost",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"mlaursen/vim-react-snippets",
			"hrsh7th/cmp-buffer", -- buffer completion
			"hrsh7th/cmp-path", -- path completion
			"hrsh7th/cmp-cmdline", -- cmdline completion
			"onsails/lspkind.nvim", -- pictograms
		},
		config = function()
			require("vim-react-snippets").lazy_load()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "BufReadPost",
		config = function()
			local lspkind = require("lspkind")
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					-- { name = 'codeium' },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
				-- lspkind
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol", -- show only symbol annotations
						maxwidth = {
							menu = 50,
							abbr = 50,
						},
						ellipsis_char = "...",
						-- symbol_map = { Codeium = "󱜚" },
						show_labelDetails = true,
						before = function(entry, vim_item)
							return vim_item
						end,
					}),
				},
			})
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!" },
						},
					},
				}),
			})
		end,
	},
	--! FORMATTING -------------------------------------------------------------
	{
		"nvimtools/none-ls.nvim",
		event = "BufRead",
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
		},
		keys = {
			{ "<leader>df", "<cmd>vim.lsp.buf.format<CR>", desc = "[f]ormat Document" },
		},
		config = function()
			local augroup = vim.api.nvim_create_augroup("LspAutoFormatting", {})
			local null_ls = require("null-ls")

      -- List & Function to check if the current directory matches any in the list
      local disabled_directories = {
        "/home/tazerblaze/Projects/react-jurorsearch",
      }
      local function is_directory_disabled()
        local cwd = vim.fn.getcwd()
        for _, dir in ipairs(disabled_directories) do
          if cwd == dir then
            return true
          end
        end
        return false
      end

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettierd.with({
            condition = function(utils)
              return not is_directory_disabled() -- Disable Prettier for matching directories
            end,
          }),
					require("none-ls.diagnostics.eslint_d"),
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ bufnr = bufnr })
							end,
						})
					end
				end,
			})
		end,
	},
}
