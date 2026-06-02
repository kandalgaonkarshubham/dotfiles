-- if true then return {} end --! WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  {
    -- https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local ts = require("nvim-treesitter")

      ts.install({
        "javascript",
        "typescript",
        "tsx",
        "html",
        "php",
        "css",
        "json",
        "json5",
        "yaml",
        "toml",
        "bash",
        "dockerfile",
        "markdown",
        "markdown_inline",
        "prisma",
        "lua",
        "vim",
        "regex",
        "http",
        "csv",
        "diff",
        "git_config",
        "gitignore",
        "nginx",
        "zsh",
        "python"
      })

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      {
        "<leader>e",
        "<cmd>NvimTreeToggle<CR>",
        desc = "Toggle File Explorer",
      },
      {
        "<leader>fe",
        "<cmd>NvimTreeFindFileToggle<CR>",
        desc = "Find Current File",
      },
    },
    opts = {
      sort_by = "case_sensitive",
      view = {
        width = 35,
        relativenumber = true,
      },
      renderer = {
        root_folder_label = false,
        icons = {
          git_placement = "after",
          glyphs = {
            git = {
              unstaged = "",
              staged = "󰸞",
              untracked = "",
              renamed = "󰑕",
              deleted = "󰆴",
              unmerged = "",
            },
          },
          show = {
            git = true,
            folder = true,
            file = true,
            folder_arrow = true,
          },
        },
      },
      filters = {
        custom = {
          "^.git$",
          "^node_modules$",
          "^.next$",
          "^dist$",
          "^coverage$",
        },
      },
      git = {
        enable = true,
        ignore = false,
      },
      actions = {
        open_file = {
          quit_on_open = false,
          resize_window = true,
        },
      },
      update_focused_file = {
        enable = true,
        update_root = false,
      },
    },
  },
}
