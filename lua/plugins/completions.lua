-- if true then return {} end --! WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

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
          "emmet_language_server",
          "lua_ls",
        },
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      -- local on_attach = function(client, bufnr)
      --   local opts = { noremap = true, silent = true, buffer = bufnr }
      --   keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
      --   keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
      --   keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
      --   keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
      --   keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
      --   keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
      --   keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
      --   keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
      --   keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
      --   keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
      --   keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
      --   keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side
      -- end

      local lspconfig = require("lspconfig")
      local servers = { 'html', 'cssls', 'tailwindcss', 'ts_ls', 'prismals', 'jsonls', 'lua_ls' }
      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          capabilities = capabilities,
          -- on_attach = on_attach
        })
        lspconfig.emmet_language_server.setup({
          capabilities = capabilities,
          filetypes = { "css", "html", "javascript", "javascriptreact", "typescriptreact", "vue" },
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
      "mlaursen/vim-react-snippets",
      "hrsh7th/cmp-buffer", -- for buffer completion
      "hrsh7th/cmp-path", -- for path completion
      "hrsh7th/cmp-cmdline", -- for cmdline completion
    },
    config = function()
      require("vim-react-snippets").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load()
    end
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
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        })
      })
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' }
            }
          }
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
    keys = {
      { "<leader>df", "<cmd>vim.lsp.buf.format<CR>", desc = "[f]ormat Document" },
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
    end
  },
}
