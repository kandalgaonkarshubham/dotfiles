-- if true then return {} end --! WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
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
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {
      disabled_keys = {
        --   ["<Up>"] = {},
        --   ["<Down>"] = {},
        ["<Left>"] = {},
        ["<Right>"] = {},
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
  {
    "mistricky/codesnap.nvim",
    tag = "v2.0.0",
    event = "VeryLazy",
    keys = {
      {
        "<leader>csc",
        ":CodeSnap<cr>",
        mode = "x",
        noremap = true,
        silent = true,
        desc = "Copy selected code snapshot into [c]lipboard",
      },
      {
        "<leader>csa",
        ":CodeSnapSave<cr>",
        mode = "x",
        noremap = true,
        silent = true,
        desc = "S[a]ve selected code snapshot locally",
      },
    },
    opts = {
      save_path = "~/Pictures/nvim",
      has_breadcrumbs = true,
      show_workspace = true,
      bg_padding = 0,
      watermark = "",
    },
  },
  {
    "zeioth/garbage-day.nvim",
    event = "VeryLazy",
  },
  -- { "pbogut/vim-dadbod-ssh" },
  {
    "esmuellert/vscode-diff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    keys = {
      {
        "<leader>gc",
        ":CodeDiff<cr>",
        mode = "n",
        noremap = true,
        silent = true,
        desc = "Git Diff (vs[c]ode)",
      },
    },
  },
}
