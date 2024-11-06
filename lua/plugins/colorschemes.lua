return {
  { "folke/tokyonight.nvim", priority = 1000 },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "shaunsingh/nord.nvim", priority = 1000 },
  { "olivercederborg/poimandres.nvim", priority = 1000 },
  { "rose-pine/neovim", name = "rose-pine", priority = 1000 },
  { "mhartington/oceanic-next" },
  { "jay-babu/colorscheme-randomizer.nvim",
    event = "VimEnter",
    config = function()
      require("colorscheme-randomizer").setup({
        apply_scheme = true,
        plugin_strategy = "lazy",
        colorschemes = { "rose-pine-moon", "poimandres", "catppuccin-mocha", "nord", "tokyonight-night", "OceanicNext" },
        exclude_colorschemes = nil,
      })
      -- [[ Set the BufferLine background ]]
      local bg_color = vim.api.nvim_get_hl_by_name("Normal", true).background
      vim.api.nvim_set_hl(0, "BufferLineFill", { bg = bg_color })

      -- [[ Check colorscheme ]]
      if vim.g.colors_name == "catppuccin-mocha" then
        require("catppuccin").setup({
          integrations = {
            noice = false,
            mason = true,
            which_key = true,
            indent_blankline = {
              colored_indent_levels = true,
            },
          }
        })
      end
    end
  },
}
