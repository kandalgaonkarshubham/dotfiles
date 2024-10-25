return {
  {
    "xiyaowong/transparent.nvim",
    config = function(plugins, opts)
      require("transparent").setup({
        extra_groups = {
          "Winbar", "WinbarNC",
          "TelescopeNormal", "TelescopeBorder",
          "NotifyINFOBorder", "NotifyWARNBorder", "NotifyERRORBorder",
          "lualine_c_inactive", "lualine_c_insert", "lualine_c_visual", "lualine_c_command", "lualine_c_replace",
          "NeoTreeNormal", "NeoTreeNormalNC", "NeoTreeWinSeparator",
          "WhichKey", "WhichKeyNormal", "MasonNormal", "LazyNormal", "NoiceCmdline", "LspInlayHint", "DiagnosticVirtualTextHint",
          "BufferCurrent", "BufferCurrentMod", "BufferCurrentSign", "BufferCurrentTarget", "BufferCurrentIndex", "BufferTabpageFill", "Tabline", "TablineFill",
          "NormalFloat", "FloatBorder",
        },
        on_clear = function() end,
      })
    end,
  },
}
