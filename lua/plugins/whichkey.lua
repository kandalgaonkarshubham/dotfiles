return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    icons = {
      group = "",
      ellipsis = "",
      breadcrumb = "",
      mappings = true,
    },
    replace = {
      ["<space>"] = "SPC",
      ["<cr>"] = "RET",
      ["<tab>"] = "TAB",
    },
    spec = {
      { '<leader>c', group = ' [C]ode', mode = { 'n', 'x' } },
      { '<leader>d', group = '󰧮 [D]ocument' },
      -- { '<leader>r', group = '󰑕 [R]ename' },
      -- { '<leader>w', group = ' [W]orkspace' },
      { '<leader>t', group = ' [T]oggle', mode = { 'n', 'x' } },
      { '<leader>g', group = ' [G]it', mode = { 'n', 'x' } },
      { '<leader>f', group = ' [F]ind', mode = { 'n', 'x' } },
      { '<leader>h', group = '󰋖 [h]elp', mode = { 'n', 'x' } },
    }
  },
  keys = {
    {
      "<leader>hk",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "[k]eymaps",
    },
  },
}
