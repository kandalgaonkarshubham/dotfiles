return {
  {
    "tris203/precognition.nvim",
    lazy = true,
    event = "BufRead",
    opts = {
      highlightColor = { fg = "#8a8583" },
    },
  },
  {
    "m4xshen/hardtime.nvim",
    lazy = true,
    dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    opts = {}
  },
}
