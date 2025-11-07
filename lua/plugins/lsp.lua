-- if true then return {} end --! WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
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
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
    },
  },
  {
    "RubixDev/mason-update-all",
    config = function()
      require("mason-update-all").setup()
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "prettierd")
      table.insert(opts.ensure_installed, "eslint_d")
      table.insert(opts.ensure_installed, "sonarlint-language-server")
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft or {}, {
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        vue = { "prettierd" },
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = vim.tbl_extend("force", opts.linters_by_ft or {}, {
        ["*"] = { "eslint_d" },
        ["_"] = { "eslint_d" },
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        vue = { "eslint_d" },
        html = { "eslint_d" },
        php = { "eslint_d" },
      })
    end,
  },
}
