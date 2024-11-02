return {
  "nvim-lualine/lualine.nvim",
  event = "VimEnter",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local function capitalize(str)
      return (str:gsub("^%l", string.upper))
    end
    local function get_attached_clients()
      local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })
      if #buf_clients == 0 then
        return "LSP Inactive"
      end
      local buf_ft = vim.bo.filetype
      local client_names = {}
      for _, client in pairs(buf_clients) do
        if client.name ~= "copilot" and client.name ~= "null-ls" then
          table.insert(client_names, capitalize(client.name))
        end
      end
      local null_ls = require("null-ls")
      local sources = null_ls.get_sources()
      for _, source in ipairs(sources) do
        if source.filetypes[buf_ft] then
          table.insert(client_names, capitalize(source.name))
        end
      end
      local unique_client_names = {}
      for _, client_name in ipairs(client_names) do
        if not vim.tbl_contains(unique_client_names, client_name) then
          table.insert(unique_client_names, client_name)
        end
      end
      return table.concat(unique_client_names, " | ")
    end
    local auto_theme_custom = require('lualine.themes.auto')
    auto_theme_custom.normal.c.bg = '#292c3c80'
    auto_theme_custom.normal.c.fg = '#89b4fa'
    require('lualine').setup({
      options = {
        icons_enabled = true,
        component_separators = '',
        section_separators = { left = '', right = '' },
        theme = auto_theme_custom,
      },
      sections = {
        lualine_a = { { 'mode', separator = { left = '' }, left_padding = 4, right_padding = 2 } },
        lualine_b = { 'filename', 'branch', 'fileformat', 'encoding' },
        lualine_c = {
          '%=', --[[ add your center compoentnts here in place of this comment ]]
        },
        lualine_x = { "diagnostics", get_attached_clients },
        lualine_y = { 'filetype', 'progress' },
        lualine_z = {
          { 'location', separator = { right = '' }, left_padding = 2 },
        },
      },
      inactive_sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' },
      },
      tabline = {},
      extensions = {},
    })
  end,
}
