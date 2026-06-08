vim.pack.add({
  { src = "https://github.com/nguyenvukhang/nvim-toggler" },
  { src = "https://github.com/tris203/precognition.nvim" },
  { src = "https://github.com/m4xshen/hardtime.nvim" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/mistricky/codesnap.nvim", tag = "v2.0.0" },
  { src = "https://github.com/zeioth/garbage-day.nvim" },
})

local map = vim.keymap.set

require("nvim-toggler").setup({
  inverses = {
    ["vim"] = "emacs",
  },
  autoselect_longest_match = false,
})
map({ "n", "v" }, "<leader>i", function()
  require("nvim-toggler").toggle()
end, { noremap = true, silent = true, desc = "[i]nverse word" })

require("precognition").setup({
  highlightColor = { fg = "#8a8583" },
  targetedMotionHints = {
    enabled = false,
  },
})

require("hardtime").setup({
  disabled_keys = {
    --   ["<Up>"] = {},
    --   ["<Down>"] = {},
    ["<Left>"] = {},
    ["<Right>"] = {},
  },
})

require("codesnap").setup({
  save_path = "~/Pictures/nvim",
  has_breadcrumbs = true,
  show_workspace = true,
  bg_padding = 0,
  watermark = "",
})
map("x", "<leader>csc", "<cmd>CodeSnap<CR>", { desc = "Copy code snapshot" })
map("x", "<leader>csa", "<cmd>CodeSnapSave<CR>", { desc = "Save code snapshot" })

require("garbage-day").setup({})
