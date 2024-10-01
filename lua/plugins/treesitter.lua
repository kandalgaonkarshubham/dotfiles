if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "gitignore",
      "html",
      "css",
      "javascript",
      "typescript",
      "tsx",
      "json",
      "php",
      "python",
      -- add more arguments for adding more treesitter parsers
    },
  },
}
