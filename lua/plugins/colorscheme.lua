-- if true then return {} end --! WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

local function random_theme()
  local themes = { "rose-pine-moon", "poimandres", "catppuccin-mocha", "nord", "tokyonight-night", "OceanicNext" }

  math.randomseed(os.time())
  local colorscheme = themes[math.random(#themes)]

  -- if colorscheme == "poimandres" then
  --   require('poimandres').setup {}
  -- end

  return colorscheme
end

return {
  { "shaunsingh/nord.nvim", priority = 1000 },
  { "olivercederborg/poimandres.nvim", priority = 1000 },
  { "rose-pine/neovim", name = "rose-pine" },
  { "mhartington/oceanic-next" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = random_theme(),
    },
  },
  {
    "xiyaowong/transparent.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>tt", "<cmd>TransparentToggle<cr>", desc = "Toggle [t]ransparency" },
    },
    config = function()
      require("transparent").setup({
        extra_groups = {
        -- Tabline
        "Winbar", "WinbarNC", "NormalFloat", "FloatBorder", "Folded",
        -- -- Telescope
        -- "TelescopeNormal", "TelescopeBorder", "TelescopePromptBorder",
        -- -- NeoTree
        -- "NeoTreeNormal", "NeoTreeNormalNC", "NeoTreeWinSeparator",
        -- WhichKey
        "WhichKey", "WhichKeyNormal","WhichKeyFloat", "WhichKeyTitle", "WhichKeyBorder", "MasonNormal", "LazyNormal",
    --     -- Noice & Notify
    --     "NoiceCmdline", "NotifyBackground", "MiniNotifyTitle", "NotifyTRACEBody", "NotifyDEBUGBody", "NotifyINFOBody", "NotifyWARNBody", "NotifyERRORBody", "NotifyDEBUGBorder", "NotifyTRACEBorder", "NotifyINFOBorder", "NotifyWARNBorder", "NotifyERRORBorder",
        -- Lsps Misc
        "LspInlayHint", "LspInfoBorder", "DiagnosticVirtualTextHint",
        -- Bufferline
        "BufferCurrent", "BufferCurrentMod", "BufferCurrentSign", "BufferCurrentTarget", "BufferCurrentIndex", "BufferTabpageFill", "BufferLineFill", "Tabline", "TablineFill",
        },
        on_clear = function() end,
      })
      -- Custom highlight for current curs0r line color
      local custom_color = vim.api.nvim_get_hl_by_name("String", true).foreground
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = custom_color, bold = true })
    end,
  },
}
