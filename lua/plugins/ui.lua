-- if true then return {} end --! WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      presets = {
        command_palette = true,
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true,
        long_message_to_split = true,
      },
    },
  }
}
