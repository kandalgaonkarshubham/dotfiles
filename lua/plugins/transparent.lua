return {
  "xiyaowong/transparent.nvim",
  config = function()
    require("transparent").setup({
      extra_groups = {
        "Winbar", "WinbarNC",
        "TelescopeNormal", "TelescopeBorder", "TelescopePromptBorder",
        "lualine_c_inactive", "lualine_c_insert", "lualine_c_visual", "lualine_c_command", "lualine_c_replace",
        "NeoTreeNormal", "NeoTreeNormalNC", "NeoTreeWinSeparator",
        "WhichKey", "WhichKeyNormal","WhichKeyFloat", "WhichKeyTitle", "WhichKeyBorder", "MasonNormal", "LazyNormal",
        "NoiceCmdline", "NotifyBackground", "MiniNotifyTitle", "NotifyTRACEBody", "NotifyDEBUGBody", "NotifyINFOBody", "NotifyWARNBody", "NotifyERRORBody", "NotifyDEBUGBorder", "NotifyTRACEBorder", "NotifyINFOBorder", "NotifyWARNBorder", "NotifyERRORBorder",
        "LspInlayHint", "LspInfoBorder", "DiagnosticVirtualTextHint",
        "BufferCurrent", "BufferCurrentMod", "BufferCurrentSign", "BufferCurrentTarget", "BufferCurrentIndex", "BufferTabpageFill", "Tabline", "TablineFill",
        "NormalFloat", "FloatBorder",
      },
      on_clear = function() end,
    })
  end,
}
