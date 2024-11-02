return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "html", "cssls", "tailwindcss",
          "ts_ls",
          "prismals", "jsonls",
          "lua_ls",
        },
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require("lspconfig")
      local servers = { 'html', 'cssls', 'tailwindcss', 'ts_ls', 'prismals', 'jsonls', 'lua_ls' }
      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          capabilities = capabilities,
        })
      end

      vim.keymap.set('n', '<leader>ch', vim.lsp.buf.hover, { desc = 'LSP [h]over' })
      vim.keymap.set('n', '<leader>cd', vim.lsp.buf.definition, { desc = 'LSP goto [d]efinition' })
      vim.keymap.set("n", "<leader>cr", vim.lsp.buf.references, { desc = 'LSP goto [r]eferences' })
      vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, { desc = 'LSP [c]ode [a]ction' })
    end
  },
}
