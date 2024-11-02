return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    event = "VeryLazy",
    tag = "0.1.8",
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find [f]iles' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live [g]rep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'List [b]uffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[h]elp Tags' })
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    config = function()
      require('telescope').load_extension('fzf')
    end
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup ({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {}
          }
        }
      })
      require("telescope").load_extension("ui-select")
    end
  },
}
