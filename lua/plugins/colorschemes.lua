return {
  { "folke/tokyonight.nvim", priority = 1000 },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "shaunsingh/nord.nvim", priority = 1000 },
  { "olivercederborg/poimandres.nvim", priority = 1000 },
  { "rose-pine/neovim", name = "rose-pine", priority = 1000 },
  { "jay-babu/colorscheme-randomizer.nvim",
    event = "VimEnter",
    config = function()
      require("colorscheme-randomizer").setup({
        apply_scheme = true,
        plugin_strategy = "lazy",
        colorschemes = { "rose-pine-moon", "poimandres", "catppuccin-mocha", "nord", "tokyonight-night" },
        exclude_colorschemes = nil,
      })
      -- [[ Set the BufferLine background ]]
      local bg_color = vim.api.nvim_get_hl_by_name("Normal", true).background
      vim.api.nvim_set_hl(0, "BufferLineFill", { bg = bg_color })
    end
  },
}
