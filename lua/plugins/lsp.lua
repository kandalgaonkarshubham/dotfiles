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
}
