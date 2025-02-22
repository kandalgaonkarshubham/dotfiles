-- if true then return {} end --! WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  {
    "gennaro-tedesco/nvim-peekup",
    cmd = "PeekupOpen",
  },
  {
    "tris203/precognition.nvim",
    event = "BufRead",
    opts = {
      highlightColor = { fg = "#8a8583" },
    },
  },
  {
    "m4xshen/hardtime.nvim",
    event = "BufRead",
    dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    opts = {
      disabled_keys = {
        ["<Up>"] = {},
        ["<Down>"] = {},
        ["<Left>"] = {},
        ["<Right>"] = {},
      },
    }
  },
  {
    "atiladefreitas/dooing",
    event = "VeryLazy",
    config = function()
      require("dooing").setup({})
    end,
  },
  {
    "ellisonleao/glow.nvim",
    cmd = "Glow",
    config = true,
  },
  {
    "mistricky/codesnap.nvim",
    build = "make",
    event = "VeryLazy",
    keys = {
      { "<leader>cc", ":CodeSnap<cr>", mode = "x", noremap = true, silent = true, desc = "Copy selected code snapshot into [c]lipboard" },
      { "<leader>ca", ":CodeSnapSave<cr>", mode = "x", noremap = true, silent = true, desc = "S[a]ve selected code snapshot locally" },
    },
    opts = {
      save_path = "~/Pictures/nvim",
      has_breadcrumbs = true,
      show_workspace = true,
      bg_padding = 0,
      watermark = "",
    },
  },
}
