return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { '<leader>tn', ':Neotree toggle<CR>', desc = 'Toggle [n]eoTree', silent = true },
    { '<leader>tf', ':Neotree focus<CR>', desc = 'Toggle [f]ocus between NeoTree & Buffer', silent = true }
  },
  opts = {
    filesystem = {
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          ".vscode",
          ".git",
          ".next"
        },
        never_show = {
          "node_modules"
        },
      },
    },
    default_component_configs = {
      diagnostics = {
        symbols = {
          hint = "󰌵",
          info = "",
          warn = "",
          error = "",
        },
      },
    },
    window = {
      position = "left",
      width = 30
    },
  },
}
