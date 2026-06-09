vim.pack.add({
  { src = "https://github.com/nguyenvukhang/nvim-toggler" },
  { src = "https://github.com/tris203/precognition.nvim" },
  { src = "https://github.com/m4xshen/hardtime.nvim" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/mistricky/codesnap.nvim", tag = "v2.0.0" },
  { src = "https://github.com/zeioth/garbage-day.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
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
map("x", "<leader>csc", "<Esc><cmd>CodeSnap<CR>", { desc = "Copy code snapshot" })
map("x", "<leader>csa", "<Esc><cmd>CodeSnapSave<CR>", { desc = "Save code snapshot" })

require("garbage-day").setup({})

require("which-key").setup({
  preset = "helix",
  spec = {
    {
      mode = { "n", "v" },
      { "<leader><tab>", group = "tabs" },
      { "<leader>c", group = "code" },
      { "<leader>d", group = "debug" },
      { "<leader>dp", group = "profiler" },
      { "<leader>f", group = "file/find" },
      { "<leader>g", group = "git" },
      { "<leader>gh", group = "hunks" },
      { "<leader>q", group = "quit/session" },
      { "<leader>s", group = "search" },
      { "<leader>u", group = "ui" },
      { "<leader>x", group = "diagnostics/quickfix" },
      { "[", group = "prev" },
      { "]", group = "next" },
      { "g", group = "goto" },
      { "gs", group = "surround" },
      { "z", group = "fold" },
      { "<leader>t", group = "Toggle", icon = { icon = " ", color = "cyan" } },
      -- { "<leader>ty", group = "Typr", icon = { icon = "󰌌 ", color = "green" } },
      -- { "<leader>tn", group = "Nomodoro", icon = { icon = " ", color = "red" } },
      { "<leader>cs", group = "CodeSnap", icon = { icon = "", color = "yellow" } },
    },
  },
})
