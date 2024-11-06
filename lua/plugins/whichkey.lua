return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup({
      preset = "modern",
      icons = {
        group = "",
        ellipsis = "",
        breadcrumb = "",
        mappings = true,
      },
      replace = {
        ["<space>"] = "󱁐",
        ["<cr>"] = "󰌑",
        ["<tab>"] = "",
      },
    })
    wk.add({
      { "<leader>c", group = " [c]ode" },

      { "<leader>d", group = "󰧮 [d]ocument" },

      { "<leader>b", group = " [b]uffer" },

      { "<leader>r", group = "󰑕 [r]ename" },

      { "<leader>f", group = " [f]ind" },

      { "<leader>g", group = " [g]it" },

      { "<leader>s", group = " [s]ession" },

      { "<leader>t", group = " [t]oggle" },

      { "<leader>h", group = "󰋖 [h]elp" },
      { "<leader>hk", "<cmd>lua require('which-key').show({ global = false })<CR>", desc = "[k]eymaps", mode = { "n" } },
    })
  end
}
