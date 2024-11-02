return {
  {
    "numToStr/Comment.nvim",
    lazy = true,
    event = "BufRead",
    opts = {
    }
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    event = "BufRead",
    config = function()
      require('ts_context_commentstring').setup {}
    end,
  }
}
