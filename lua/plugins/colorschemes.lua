vim.pack.add({
  { src = "https://github.com/shaunsingh/nord.nvim" },
  { src = "https://github.com/olivercederborg/poimandres.nvim" },
  { src = "https://github.com/rose-pine/neovim" },
  { src = "https://github.com/catppuccin/nvim" },
  { src = "https://github.com/mhartington/oceanic-next" },
  { src = "https://github.com/eldritch-theme/eldritch.nvim" },
  { src = "https://github.com/lunarvim/horizon.nvim" },
  { src = "https://github.com/folke/tokyonight.nvim" },

  { src = "https://github.com/xiyaowong/transparent.nvim" },
})

-- ColorScheme Loader
local themes = {
  "rose-pine-moon",
  "poimandres",
  "catppuccin-mocha",
  "nord",
  "tokyonight-night",
  "OceanicNext",
  "eldritch",
  "horizon",
}

math.randomseed(vim.uv.hrtime())

local selected = themes[math.random(#themes)]
vim.cmd.colorscheme(selected)

vim.schedule(function()
  local string_hl = vim.api.nvim_get_hl(0, {
    name = "String",
  })

  if string_hl.fg then
    vim.api.nvim_set_hl(0, "CursorLineNr", {
      fg = string_hl.fg,
      bold = true,
    })
  end
end)

-- Transparent Nvim
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  once = true,
  callback = function()
    require("transparent").setup({
      extra_groups = {
        "Winbar",
        "WinbarNC",
        "NormalFloat",
        "FloatBorder",
        "Folded",

        "NeoTreeNormal",
        "NeoTreeNormalNC",
        "NeoTreeWinSeparator",

        "WhichKey",
        "WhichKeyNormal",
        "WhichKeyFloat",
        "WhichKeyTitle",
        "WhichKeyBorder",

        "MasonNormal",
        "LazyNormal",

        "NoiceCmdline",
        "NotifyBackground",
        "MiniNotifyTitle",
        "SnacksNotifierTrace",
        "SnacksNotifierDebug",
        "SnacksNotifierInfo",
        "SnacksNotifierWarn",
        "SnacksNotifierError",
        "SnacksNotifierBorderTrace",
        "SnacksNotifierBorderDebug",
        "SnacksNotifierBorderInfo",
        "SnacksNotifierBorderWarn",
        "SnacksNotifierBorderError",

        "LspInlayHint",
        "LspInfoBorder",
        "DiagnosticVirtualTextHint",

        "BufferCurrent",
        "BufferCurrentMod",
        "BufferCurrentSign",
        "BufferCurrentTarget",
        "BufferCurrentIndex",
        "BufferTabpageFill",
        "BufferLineFill",
        "Tabline",
        "TablineFill",
      },
      on_clear = function() end,
    })
  end,
})

vim.keymap.set(
  "n",
  "<leader>tt",
  "<cmd>TransparentToggle<CR>",
  { desc = "Toggle [t]ransparency" }
)
