-- if true then return {} end --! WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  {
    -- https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local ts = require("nvim-treesitter")

      ts.install({
        "javascript",
        "typescript",
        "tsx",
        "html",
        "php",
        "css",
        "json",
        "json5",
        "yaml",
        "toml",
        "bash",
        "dockerfile",
        "markdown",
        "markdown_inline",
        "prisma",
        "lua",
        "vim",
        "regex",
        "http",
        "csv",
        "diff",
        "git_config",
        "gitignore",
        "nginx",
        "zsh",
        "python"
      })

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  }
}
