return {
  "nvim-treesitter/nvim-treesitter",
  event = "VeryLazy",
  dependencies = { 'HiPhish/rainbow-delimiters.nvim' },
  build = ":TSUpdate",
  config = function()
    local rainbow_delimiters = require 'rainbow-delimiters'
    local config = require("nvim-treesitter.configs")
    config = config.setup({
      ensure_installed = {
        "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline",
        "html", "css", "javascript", "typescript", "tsx", "prisma", "json",
      },
      auto_install = true,
      indent = { enable = true },
      highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
      require('rainbow-delimiters.setup').setup {}
    })
  end
}
