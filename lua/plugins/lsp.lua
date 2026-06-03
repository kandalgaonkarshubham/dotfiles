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
    end,
  },
  {
    "schrieveslaach/sonarlint.nvim",
    url = "https://gitlab.com/schrieveslaach/sonarlint.nvim",
    ft = { "html", "php", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    enabled = true,
    config = function()
      require("sonarlint").setup({
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
    end,
  },
}
