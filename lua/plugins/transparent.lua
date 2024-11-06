return {
  "xiyaowong/transparent.nvim",
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
    vim.keymap.set("n", "<leader>tt", "<cmd>TransparentToggle<CR>", { desc = "[t]oggle Transparent Mode" })
  end,
}
