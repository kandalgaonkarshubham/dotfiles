-- if true then return {} end --! WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  { "folke/tokyonight.nvim", priority = 1000 },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "shaunsingh/nord.nvim", priority = 1000 },
  { "olivercederborg/poimandres.nvim", priority = 1000 },
  { "rose-pine/neovim", name = "rose-pine", priority = 1000 },
  { "mhartington/oceanic-next" },
  { "jay-babu/colorscheme-randomizer.nvim",
    config = function()
      require("colorscheme-randomizer").setup({
        apply_scheme = true,
        plugin_strategy = "lazy",
        colorschemes = { "rose-pine-moon", "poimandres", "catppuccin-mocha", "nord", "tokyonight-night", "OceanicNext" },
        exclude_colorschemes = nil,
      })
      -- [[ Set the BufferLine background ]]
      -- local bg_color = vim.api.nvim_get_hl_by_name("Normal", true).background
      -- vim.api.nvim_set_hl(0, "BufferLineFill", { bg = bg_color })

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
  {
    "xiyaowong/transparent.nvim",
    event = "VimEnter",
    keys = {
      { "<leader>tt", "<cmd>TransparentToggle<cr>", desc = "[t]oggle [t]ransparency" },
    },
    config = function()
      require("transparent").setup({
        extra_groups = {
          -- Tabline
          "Winbar", "WinbarNC", "NormalFloat", "FloatBorder", "Folded",
          -- Telescope
          "TelescopeNormal", "TelescopeBorder", "TelescopePromptBorder",
          -- Lualine
          "lualine_c_inactive", "lualine_c_insert", "lualine_c_visual", "lualine_c_command", "lualine_c_replace",
          -- NeoTree
          "NeoTreeNormal", "NeoTreeNormalNC", "NeoTreeWinSeparator",
          -- WhichKey
          "WhichKey", "WhichKeyNormal","WhichKeyFloat", "WhichKeyTitle", "WhichKeyBorder", "MasonNormal", "LazyNormal",
          -- Noice & Notify
          "NoiceCmdline", "NotifyBackground", "MiniNotifyTitle", "NotifyTRACEBody", "NotifyDEBUGBody", "NotifyINFOBody", "NotifyWARNBody", "NotifyERRORBody", "NotifyDEBUGBorder", "NotifyTRACEBorder", "NotifyINFOBorder", "NotifyWARNBorder", "NotifyERRORBorder",
          -- Lsps Misc
          "LspInlayHint", "LspInfoBorder", "DiagnosticVirtualTextHint",
          -- Bufferline
          "BufferCurrent", "BufferCurrentMod", "BufferCurrentSign", "BufferCurrentTarget", "BufferCurrentIndex", "BufferTabpageFill", "BufferLineFill", "Tabline", "TablineFill",
        },
        on_clear = function() end,
      })
    end,
  },
}
