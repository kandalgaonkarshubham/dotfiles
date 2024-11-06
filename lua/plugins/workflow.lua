return {
  {
    "tris203/precognition.nvim",
    lazy = true,
    event = "BufRead",
    opts = {
      highlightColor = { fg = "#8a8583" },
    },
  },
  {
    "m4xshen/hardtime.nvim",
    lazy = true,
    dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    opts = {}
  },
  {
    "rmagatti/auto-session",
    lazy = false,
    keys = {
      { '<leader>ss', '<cmd>SessionSave<CR>', desc = "[s]ave Session" },
      { '<leader>sr', '<cmd>SessionRestore<CR>', desc = "[r]estore Session" },
      { '<leader>sh', '<cmd>SessionSearch<CR>', desc = "searc[h] Session" },
      { '<leader>sd', '<cmd>SessionDelete<CR>', desc = "[d]elete Session" },
      { '<leader>sp', '<cmd>SessionPurgeOrphaned<CR>', desc = "[p]urge Orphaned Sessions" },
      { '<leader>sa', '<cmd>SessionToggleAutoSave<CR>', desc = "Toggle Session [a]utosave" },
    },
    opts = {
      suppressed_dirs = { '~/', '~/Web', '~/Downloads', '/' },
      bypass_save_filetypes = { '', ' ', 'nofile', 'help', 'alpha', 'startify', 'dashboard', 'neo-tree' },
      -- log_level = 'error',
      auto_restore_enabled = false,
    },
  },
}
