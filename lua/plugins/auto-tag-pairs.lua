return{
  {
    "windwp/nvim-ts-autotag",
    event = "BufRead",
    ft = {
      "html",
      "php",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
    },
    config = function()
      require('nvim-ts-autotag').setup({
        opts = {
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = false -- Auto close on trailing </
        },
        per_filetype = {
          -- ["html"] = {
          --   enable_close = false
          -- }
        }
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = 'BufRead',
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = true,
    init = function()
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "BufRead",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
}
