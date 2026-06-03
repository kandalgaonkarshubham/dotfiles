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
  local string_hl = vim.api.nvim_get_hl(
    0,
    { name = "String" }
  )

  if string_hl.fg then
    vim.api.nvim_set_hl(
      0,
      "CursorLineNr",
      {
        fg = string_hl.fg,
        bold = true,
      }
    )
  end
end)
-- ColorScheme Loader
