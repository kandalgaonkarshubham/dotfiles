return {
  "akinsho/bufferline.nvim",
  event = "BufRead",
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    vim.opt.termguicolors = true
    require("bufferline").setup({
      options = {
        themable = true,
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            separator = true,
            text_align = "left",
          },
        },
        diagnostics = "nvim_lsp",
        separator_style = { "", "" },
        color_icons = true,
      },
    })
    vim.keymap.set('n', '<Leader>bb', ':BufferLinePick<CR>', { desc = '[p]ick a buffer' })

    vim.keymap.set('n', '<Leader>b[', ':BufferLineCyclePrev<CR>', { desc = 'Move to the PREV buffer' })
    vim.keymap.set('n', '<Leader>b]', ':BufferLineCycleNext<CR>', { desc = 'Move to the NEXT buffer' })

    vim.keymap.set('n', '<Leader>b<', ':BufferLineMovePrev<CR>', { desc = ' Move buffer to the LEFT' })
    vim.keymap.set('n', '<Leader>b>', ':BufferLineMoveNext<CR>', { desc = ' Move buffer to the RIGHT' })

    vim.keymap.set('n', '<Leader>bc', ':bd<CR>', { desc = '[c]lose the Current Buffer' })
    vim.keymap.set('n', '<Leader>bl', ':BufferLinePickClose<CR>', { desc = 'Pick a buffer via [l]abel to close' })
    vim.keymap.set('n', '<Leader>bo', ':BufferLineCloseLeft<CR>:BufferLineCloseRight<CR>', { desc = 'Close all buffers except the current [o]ne' })
  end,
}
