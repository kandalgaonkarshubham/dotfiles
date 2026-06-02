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
}
