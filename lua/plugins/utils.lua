vim.pack.add({
  { src = "https://github.com/nguyenvukhang/nvim-toggler" },
  { src = "https://github.com/tris203/precognition.nvim" },
  { src = "https://github.com/m4xshen/hardtime.nvim" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/mistricky/codesnap.nvim", tag = "v2.0.0" },
  { src = "https://github.com/zeioth/garbage-day.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/Owen-Dechow/videre.nvim" },
  { src = "https://github.com/Owen-Dechow/graph_view_yaml_parser" },
  { src = "https://github.com/Owen-Dechow/graph_view_toml_parser" },
  { src = "https://github.com/a-usr/xml2lua.nvim" },
  { src = "https://github.com/Kenzo-Wada/boundary.nvim", version = "release" },
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
  show_workspace = true,
  snapshot_config = {
    watermark = {
      content = "",
    },
    window = {
      margin = {
        x = 0,
        y = 0,
      },
    },
    background = {
      start = { x = 0, y = 0 },
      ["end"] = { x = "max", y = 0 },
      stops = {
        { position = 0, color = "#00000000" },
        { position = 1, color = "#00000000" },
      },
    },
  },
})
map("x", "<leader>csc", "<Esc><cmd>CodeSnap<CR>", { desc = "Copy code snapshot" })
map("x", "<leader>csa", "<Esc><cmd>CodeSnapSave ~/Pictures/nvim/snap.png<CR>", { desc = "Save code snapshot" })

require("garbage-day").setup({})

require("which-key").setup({
  preset = "helix",
  spec = {
    {
      mode = { "n", "v" },

      { "<leader><tab>", group = "Tabs", icon = { icon = "󰓩 ", color = "cyan" } },
      { "<leader>c", group = "Code", icon = { icon = " ", color = "blue" } },
      { "<leader>b", group = "Buffer", icon = { icon = "󰈔 ", color = "cyan" } },
      { "<leader>d", group = "Debug", icon = { icon = " ", color = "red" } },
      { "<leader>dp", group = "Profiler", icon = { icon = "󰄉 ", color = "orange" } },
      { "<leader>f", group = "File/Find", icon = { icon = "󰈞 ", color = "green" } },
      { "<leader>g", group = "Git", icon = { icon = "󰊢 ", color = "orange" } },
      { "<leader>gh", group = "Hunks", icon = { icon = "󰊢 ", color = "yellow" } },
      -- { "<leader>q", group = "Quit/Session", icon = { icon = "󰗼 ", color = "red" } },

      { "<leader>s", group = "Search", icon = { icon = " ", color = "green" } },
      { "<leader>u", group = "UI", icon = { icon = "󰙵 ", color = "purple" } },
      { "<leader>x", group = "Diagnostics/Quickfix", icon = { icon = " ", color = "yellow" } },

      { "[", group = "Previous", icon = { icon = " ", color = "blue" } },
      { "]", group = "Next", icon = { icon = " ", color = "blue" } },
      { "g", group = "Goto", icon = { icon = "󰁔 ", color = "cyan" } },
      { "gs", group = "Surround", icon = { icon = "󰅪 ", color = "purple" } },
      { "z", group = "Fold", icon = { icon = " ", color = "orange" } },

      { "<leader>t", group = "Toggle", icon = { icon = " ", color = "cyan" } },
      -- { "<leader>ty", group = "Typr", icon = { icon = "󰌌 ", color = "green" } },
      -- { "<leader>tn", group = "Nomodoro", icon = { icon = " ", color = "red" } },

      { "<leader>cs", group = "CodeSnap", icon = { icon = "󰄄 ", color = "yellow" } },
    },
  },
})

require("videre").setup {
    box_style = "sharp",
}
map("n", "<leader>cg", "<Esc><cmd>Videre<CR>", { desc = "Open Data Graph" })

require("boundary").setup({
    marker_text = "Client Component",
})
