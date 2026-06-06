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

-- neovim/nvim-lspconfig
vim.diagnostic.config({ virtual_text = true })

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend(
  "force",
  capabilities,
  require("mini.completion").get_lsp_capabilities()
)

vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
    },
  },
})

vim.lsp.enable(lsp_servers)

-- mason-org/mason-lspconfig.nvim
require("mason-lspconfig").setup({
  ensure_installed = lsp_servers,
})

-- WhoIsSethDaniel/mason-tool-installer.nvim
require("mason").setup()
require("mason-tool-installer").setup({
  ensure_installed = tools,
})

-- RubixDev/mason-update-all
require("mason-update-all").setup()

-- schrieveslaach/sonarlint.nvim (https://gitlab.com/schrieveslaach/sonarlint.nvim)
require("sonarlint").setup({
  server = {
    cmd = {
      "sonarlint-language-server",
      "-stdio",
      "-analyzers",
      vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarhtml.jar"),
      vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarphp.jar"),
      vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjs.jar"),
      -- vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
      -- vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcfamily.jar"),
      -- vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
      "--log-level",
      "DEBUG",
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

-- mfussenegger/nvim-lint
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
