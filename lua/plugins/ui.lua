vim.pack.add({
  -- Noice
  { src = "https://github.com/folke/noice.nvim" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },
  { src = "https://github.com/rcarriga/nvim-notify"}

})

require("noice").setup({
  presets = {
    command_palette = true,
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = true,
    long_message_to_split = true,
  },
  routes = {
    {
      filter = {
        event = "notify",
        find = "No information available",
      },
      opts = { skip = true },
    },
  },
})
