vim.pack.add({
  -- nvim-lspconfig
  { src = "https://github.com/neovim/nvim-lspconfig" },
  -- Mason
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
  { src = "https://github.com/RubixDev/mason-update-all" },

  -- Linting
  { src = "https://github.com/mfussenegger/nvim-lint" },
  { src = "https://gitlab.com/schrieveslaach/sonarlint.nvim" },

  -- Formatters
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },
  { src = "https://github.com/rachartier/tiny-code-action.nvim" },

  -- Completions
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/Saghen/blink.lib" },
	{ src = "https://github.com/Saghen/blink.cmp" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
})

local lsp_servers = {
  "lua_ls",
  "ts_ls",
  "html",
  "cssls",
  "jsonls",
  "tailwindcss",
  "vue_ls",
  "marksman",
  "prismals",
  "phpactor",
  "eslint",
}
local linters = {
  "sonarlint-language-server",
  "dotenv-linter",
}
local formatters = {
  "prettierd",
  "stylua",
}
local tools = vim.list_extend(vim.deepcopy(linters), formatters)

-- lsp
vim.diagnostic.config({ virtual_text = true })
vim.lsp.enable(lsp_servers)
vim.api.nvim_create_autocmd(
	"LspAttach",
	{ --  Use LspAttach autocommand to only map the following keys after the language server attaches to the current buffer
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(ev)
			vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc" -- Enable completion triggered by <c-x><c-o>

			local opts = function(desc)
				return { buffer = ev.buf, silent = true, desc = desc }
			end
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
			vim.keymap.set("n", "<leader><space>", vim.lsp.buf.hover, opts("Hover documentation"))
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
			vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts("Go to type definition"))
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename symbol"))
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts("Find references"))

			vim.keymap.set({ "n", "v" }, "<leader>ca", function()
				require("tiny-code-action").code_action()
			end, opts("Code action"))
			vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts("Format buffer"))

			vim.keymap.set("n", "<leader>d", function()
				vim.diagnostic.open_float({
					border = "rounded",
				})
			end, opts("Show diagnostics float"))
		end,
	}
)

-- mason
require("mason").setup()
require("mason-tool-installer").setup({
  ensure_installed = tools,
})
require("mason-lspconfig").setup({
  ensure_installed = lsp_servers,
})
require("mason-update-all").setup()

-- linting

local lint = require("lint")

lint.linters_by_ft = {
  dotenv = { "dotenv_linter" },
  javascript = { "eslint" },
  typescript = { "eslint" },
  javascriptreact = { "eslint" },
  typescriptreact = { "eslint" },
  html = { "eslint" },
  css = { "eslint" },
  json = { "eslint" },
  vue = { "eslint" },
  markdown = { "eslint" },
  lua = { "eslint" },
  php = { "eslint" },
}

vim.api.nvim_create_autocmd(
  { "BufEnter", "BufWritePost", "InsertLeave" },
  {
    callback = function()
      lint.try_lint()
    end,
  }
)

-- require("sonarlint").setup({
--   server = {
--     cmd = {
--       "sonarlint-language-server",
--       "-stdio",
--       "-analyzers",
--       vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarhtml.jar"),
--       vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarphp.jar"),
--       vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjs.jar"),
--       -- vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
--       -- vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcfamily.jar"),
--       -- vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
--       "--log-level",
--       "DEBUG",
--     },
--     settings = {
--       sonarlint = {
--         test = "test",
--         rules = {
--           ["typescript:S101"] = { level = "on", parameters = { format = "^[A-Z][a-zA-Z0-9]*$" } },
--           ["typescript:S103"] = { level = "on", parameters = { maximumLineLength = 180 } },
--           ["typescript:S106"] = { level = "on" },
--           ["typescript:S107"] = { level = "on", parameters = { maximumFunctionParameters = 7 } },
--         },
--       },
--     },
--   },
--   filetypes = {
--     "html",
--     "php",
--     "javascript",
--     "typescript",
--     "javascriptreact",
--     "typescriptreact",
--     -- 'python',
--     -- 'cpp',
--     -- 'java',
--   },
-- })

-- stevearc/conform.nvim
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescriptreact = { "prettierd" },
    php = { "prettierd" },
    html = { "prettierd" },
    css = { "prettierd" },
    json = { "prettierd" },
    vue = { "prettierd" },
    markdown = { "prettierd" },
  },
})

require("nvim-ts-autotag").setup()

-- Completions

vim.api.nvim_create_autocmd("PackChanged", {
	desc = "Build blink.cmp after install/update",
	group = vim.api.nvim_create_augroup("blink_build", { clear = true }),
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "blink.cmp" and (kind == "install" or kind == "update") then
			vim.notify("Building blink.cmp...", vim.log.levels.INFO)
			local obj = vim.system({ "cargo", "build", "--release" }, { cwd = ev.data.path }):wait()
			if obj.code == 0 then
				vim.notify("Building blink.cmp done", vim.log.levels.INFO)
			else
				vim.notify("Building blink.cmp failed", vim.log.levels.ERROR)
			end
		end
	end,
})

require("luasnip.loaders.from_vscode").lazy_load()

require("blink.cmp").setup({
	snippets = { preset = "luasnip" },
	keymap = {
		preset = "default",
		["<Tab>"] = { "accept", "fallback" },
		["<CR>"] = { "accept", "fallback" },
		["<S-Tab>"] = { "show" },
		["<S-j>"] = { "select_next", "fallback" },
		["<S-k>"] = { "select_prev", "fallback" },
	},
	completion = {
		menu = {
			auto_show = true,
			draw = {
				treesitter = { "lsp" },
				columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
			},
		},
		documentation = { auto_show = true },
	},
	signature = { enabled = true },
	fuzzy = { implementation = "lua" },
	sources = {
		default = {
			"lsp",
			"path",
			"snippets",
			"buffer",
		},
		per_filetype = {
			sql = { "lsp", "snippets", "buffer" },
		},
		providers = {
			lsp = {
				score_offset = 90,
			},
		},
	},
	cmdline = {
		keymap = { preset = "inherit" },
		completion = { menu = { auto_show = true } },
    -- sources = { 'buffer', 'cmdline' },
	},
})
