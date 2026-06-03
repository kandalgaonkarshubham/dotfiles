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
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    opts = function()
      local function lsp_names()
        local clients = vim.lsp.get_clients({ bufnr = 0 })

        if #clients == 0 then
          return ""
        end

        local names = {}
        for _, client in ipairs(clients) do
          table.insert(names, client.name)
        end

        return table.concat(names, ", ")
      end

      local function recording()
        local reg = vim.fn.reg_recording()
        if reg == "" then
          return ""
        end

        return "REC @" .. reg
      end

      return {
        options = {
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "typr", "ministarter", "snacks_dashboard" } },
          theme = "auto",
          component_separators = '',
          section_separators = { left = '', right = '' },
        },

        sections = {
          lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },

          lualine_b = {
            "branch",
            {
              -- show file status
              function()
                if vim.bo.modified then
                  return ""
                elseif not vim.bo.modifiable or vim.bo.readonly then
                  return "" -- ReadOnly
                end
                return ""
              end,
              color = function()
                if vim.bo.modified then
                  return { fg = "#ff4500" }
                elseif not vim.bo.modifiable or vim.bo.readonly then
                  return { fg = "#ff007f" }
                end
                return { fg = "#39ff14" }
              end,
            },
          },

          lualine_c = {
            {
              "filename",
              path = 0, -- filename only
            },
          },

          lualine_x = {
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
            },

            {
              "filetype",
              icon_only = false,
            },

            lsp_names,

            "searchcount",

            recording,
          },

          lualine_y = {},

          lualine_z = {
            { 'location', separator = { right = '' }, left_padding = 2 },
          },
        },
      }
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    dependencies = {
      "HiPhish/rainbow-delimiters.nvim",
    },
    config = function()
      local hooks = require("ibl.hooks")

      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }

      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)

      vim.g.rainbow_delimiters = {
        highlight = highlight,
      }

      require("ibl").setup({
        indent = {
          char = "│",
        },

        scope = {
          enabled = true,
          highlight = highlight,
          show_start = false,
          show_end = false,
        },
      })

      hooks.register(
        hooks.type.SCOPE_HIGHLIGHT,
        hooks.builtin.scope_highlight_from_extmark
      )
    end,
  },
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        icons ={
          git = {
            enabled = true,
            commit = "󰜘 ",
            added = " ",
            modified  = "○",
            ignored = "◌ ",
            unstaged = " ",
            staged = "󰸞 ",
            untracked = " ",
            renamed = "󰑕 ",
            deleted = "󰆴 ",
            unmerged = " ",
          },
        }
      },
      explorer = {},
      lazygit = {}
    },
    keys = {
      { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
      { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>n", "<cmd>Noice history<cr>", desc = "Notification History" },
      { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
      -- git
      { "<leader>gg", function() Snacks.lazygit() end, desc = "LazyGit" },
      { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
      { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
      -- gh
      { "<leader>gi", function() Snacks.picker.gh_issue() end, desc = "GitHub Issues (open)" },
      { "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "GitHub Issues (all)" },
      { "<leader>gp", function() Snacks.picker.gh_pr() end, desc = "GitHub Pull Requests (open)" },
      { "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "GitHub Pull Requests (all)" },
      -- LSP
      { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
      { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
      { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
      { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
      { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    }
  },
  {
    "nvim-mini/mini.surround",
    version = false,
    config = function()
      require("mini.surround").setup()
    end,
  },
  {
    "nvim-mini/mini.extra",
    version = false,
    dependencies = {
      "nvim-mini/mini.pick",
    },
    config = function()
      require("mini.extra").setup()

      local map = vim.keymap.set

      map("n", "<leader>xx", MiniExtra.pickers.diagnostic, { desc = "Diagnostics" })
    end,
  },
  {
    "nvim-mini/mini.completion",
    version = false,
    config = function()
      require("mini.completion").setup({
        lsp_completion = {
          auto_setup = true,
        }
      })
    end,
  },
  {
    "nvim-mini/mini.snippets",
    version = false,
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local MiniSnippets = require("mini.snippets")
      MiniSnippets.setup({
        snippets = {
          MiniSnippets.gen_loader.from_lang(), -- loads friendly-snippets
        },
      })
      MiniSnippets.start_lsp_server({ match = false })
    end,
  }
}
