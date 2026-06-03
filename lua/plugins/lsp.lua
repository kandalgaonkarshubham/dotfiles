-- if true then return {} end --! WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

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
  "prettier",
  "stylua",
}
local tools = vim.list_extend(vim.deepcopy(linters), formatters)

return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format Local buffer" })

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
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = lsp_servers,
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
    },
    opts = {
      ensure_installed = tools,
    },
  },
  {
    "RubixDev/mason-update-all",
    config = function()
      require("mason-update-all").setup()
    end
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        php = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        json = { "prettier" },
        vue = { "prettier" },
        markdown = { "prettier" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        dotenv = { "dotenv_linter" },
        javascript = { "eslint", "sonarlint-language-server" },
        typescript = { "eslint", "sonarlint-language-server" },
        javascriptreact = { "eslint", "sonarlint-language-server" },
        typescriptreact = { "eslint", "sonarlint-language-server" },
        html = { "eslint", "sonarlint-language-server" },
        css = { "eslint", "sonarlint-language-server" },
        json = { "eslint", "sonarlint-language-server" },
        vue = { "eslint", "sonarlint-language-server" },
        markdown = { "eslint", "sonarlint-language-server" },
        lua = { "eslint", "sonarlint-language-server" },
        php = { "eslint", "sonarlint-language-server" },
      }

      vim.api.nvim_create_autocmd(
        { "BufEnter", "BufWritePost", "InsertLeave" },
        {
          callback = function()
            lint.try_lint()
          end,
        }
      )
    end,
  },
}
