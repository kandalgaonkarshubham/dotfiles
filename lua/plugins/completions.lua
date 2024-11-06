return {
  --! LSP -------------------------------------------------------------
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
    },
  },
  {
    "hrsh7th/nvim-cmp",
    event = 'BufReadPost',
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
        })
      })
    end
  },
  --! FORMATTING -------------------------------------------------------------
  {
    "nvimtools/none-ls.nvim",
    event = "BufRead",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      local augroup = vim.api.nvim_create_augroup("LspAutoFormatting", {})
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettierd,
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
      vim.keymap.set("n", "<leader>df", vim.lsp.buf.format, { desc = "[f]ormat Document" })
    end
  },
}
