vim.pack.add({
  -- Lsp
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
vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = { current_line = true },
  underline = true,
  update_in_insert = false,
  signs = false,
})

vim.api.nvim_create_autocmd({ 'CursorMoved', 'DiagnosticChanged' }, {
  group = vim.api.nvim_create_augroup('diagnostic_only_virtlines', { clear = true }),
  callback = function()
    local cfg = vim.diagnostic.config()
    local curr = cfg.virtual_lines
    if not (curr and type(curr) == 'table' and curr.current_line) then
      vim.diagnostic.config({ virtual_text = cfg.virtual_text })
      return
    end

    local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
    if vim.tbl_isempty(vim.diagnostic.get(0, { lnum = lnum })) then
      vim.diagnostic.config({ virtual_text = true })
    else
      vim.diagnostic.config({ virtual_text = false })
    end
  end,
})

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
}

vim.api.nvim_create_autocmd(
  { "BufEnter", "BufWritePost", "InsertLeave" },
  {
    callback = function()
      lint.try_lint()
    end,
  }
)

local sonarlint_ft = {
  -- "c",
  -- "cpp",
  "css",
  "docker",
  "html",
  -- "java",
  "javascript",
  "javascriptreact",
  "php",
  -- "python",
  "typescript",
  "typescriptreact",
  "xml",
  "yaml.docker-compose",
}
local analyzers_path = vim.fn.stdpath "data" .. "/mason/packages/sonarlint-language-server/extension/analyzers/"
require("sonarlint").setup({
  server = {
    cmd = {
      "sonarlint-language-server",
      "-stdio",
      "-analyzers",
      analyzers_path .. "sonarhtml.jar",
      analyzers_path .. "sonariac.jar",
      -- analyzers_path .. "sonarjava.jar",
      -- analyzers_path .. "sonarjavasymbolicexecution.jar",
      analyzers_path .. "sonarjs.jar",
      analyzers_path .. "sonarphp.jar",
      -- analyzers_path .. "sonarpython.jar",
      analyzers_path .. "sonarxml.jar",
      -- "--log-level",
      -- "DEBUG",
    },
    on_attach = function(client, bufnr)
      if client._notify_overridden then
        return
      end
      client._notify_overridden = true

      -- Force full document sync so we can safely discard intermediate changes when debouncing
      if client.server_capabilities.textDocumentSync then
        if type(client.server_capabilities.textDocumentSync) == "table" then
          client.server_capabilities.textDocumentSync.change = 1 -- Full sync
        else
          client.server_capabilities.textDocumentSync = {
            change = 1,
            openClose = true,
          }
        end
      end

      local original_notify = client.notify
      local uv = vim.uv or vim.loop
      local timer = uv.new_timer()

      client.notify = function(self, method, params)
        local client_self, actual_method, actual_params
        if type(self) == "string" then
          actual_method = self
          actual_params = method
          client_self = client
        else
          actual_method = method
          actual_params = params
          client_self = self
        end

        if actual_method == "textDocument/didChange" then
          timer:stop()
          timer:start(1000, 0, vim.schedule_wrap(function()
            original_notify(client_self, "textDocument/didChange", actual_params)
          end))
          return true
        else
          return original_notify(self, method, params)
        end
      end
    end,
  },
  filetypes = sonarlint_ft,
})

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
    ["<Down>"] = { "select_next", "fallback" },
    ["<Up>"] = { "select_prev", "fallback" },
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
		keymap = {
			preset = "cmdline",
			["<Tab>"] = { "show", "accept" },
			["<S-Tab>"] = { "show", "select_prev" },
			["<Down>"] = { "select_next", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<CR>"] = { "fallback" },
		},
		completion = {
			menu = {
				auto_show = function(ctx)
					return vim.fn.getcmdtype() == ":"
				end,
			},
		},
	},
})
