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
  "eslint",
}
local tools = {
  "sonarlint-language-server",
  "prettier",
  "php-cs-fixer",
  "dotenv-linter",
}

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
    "WhoIsSetxzhDaniel/mason-tool-installer.nvim",
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
  }
}
