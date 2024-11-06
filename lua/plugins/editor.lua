return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    dependencies = { 'HiPhish/rainbow-delimiters.nvim' },
    build = ":TSUpdate",
    config = function()
      local rainbow_delimiters = require 'rainbow-delimiters'
      local config = require("nvim-treesitter.configs")
      config = config.setup({
        ensure_installed = {
          "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline",
          "html", "css", "javascript", "typescript", "tsx", "prisma", "json",
        },
        auto_install = true,
        indent = { enable = true },
        highlight = {
          enable = true,
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
        require('rainbow-delimiters.setup').setup {}
      })
    end
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    main = "ibl",
    opts = {
      indent = {
        char = "▏",
      },
    }
  },
  {
    "NvChad/nvim-colorizer.lua",
    lazy = true,
    event = "BufRead",
    config = function()
      require("colorizer").setup {}
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "BufRead",
    ft = {
      "html",
      "php",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
    },
    config = function()
      require('nvim-ts-autotag').setup({
        opts = {
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = false -- Auto close on trailing </
        },
        per_filetype = {
          -- ["html"] = {
          --   enable_close = false
          -- }
        }
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = 'BufRead',
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = true,
    init = function()
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "BufRead",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  {
    "numToStr/Comment.nvim",
    lazy = true,
    event = "BufRead",
    opts = {
    }
  },
  {
    "folke/twilight.nvim",
    opts = {
      -- context = 10, -- amount of lines we will try to show around the current line
      -- exclude = {}, -- exclude these filetypes
    }
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    event = "BufRead",
    config = function()
      require('ts_context_commentstring').setup {}
    end,
  },
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
  {
    "akinsho/toggleterm.nvim",
    lazy = true,
    event = "VeryLazy",
    version = "*",
    opts = {
      open_mapping = [[<c-`>]],
      size = 20,
    }
  },
  { "gennaro-tedesco/nvim-peekup" },

}
