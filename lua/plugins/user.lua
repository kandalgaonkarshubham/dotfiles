-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      -- opts.section.header.val = {
      --   " █████  ███████ ████████ ██████   ██████",
      --   "██   ██ ██         ██    ██   ██ ██    ██",
      --   "███████ ███████    ██    ██████  ██    ██",
      --   "██   ██      ██    ██    ██   ██ ██    ██",
      --   "██   ██ ███████    ██    ██   ██  ██████",
      --   " ",
      --   "    ███    ██ ██    ██ ██ ███    ███",
      --   "    ████   ██ ██    ██ ██ ████  ████",
      --   "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
      --   "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
      --   "    ██   ████   ████   ██ ██      ██",
      -- }
      opts.section.header.val = {
        [[                                                                       ]],
        [[                                                                     ]],
        [[       ████ ██████           █████      ██                     ]],
        [[      ███████████             █████                             ]],
        [[      █████████ ███████████████████ ███   ███████████   ]],
        [[     █████████  ███    █████████████ █████ ██████████████   ]],
        [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
        [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
        [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
      }
      return opts
    end,
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = true }, -- false by default

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
  {
    "xiyaowong/transparent.nvim",
    config = function(plugins, opts)
      require("transparent").setup({
        groups = {
          'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
          'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
          'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
          'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
          'EndOfBuffer',
        },
        extra_groups = {
          -- NeoTree
          'NeoTreeNormal', 'NeoTreeNormalNC', 'NeoTreeEndOfBuffer',
          'NeoTreeCursorLine', 'NeoTreeVertSplit', 'NeoTreeWinSeparator', 'NeoTreeStatusLine',
          'NeoTreeTabSeparatorInactive', 'NeoTreeTabSeparatorActive', 'NeoTreeTabInactive',
          -- Telescope
          "TelescopeNormal", "TelescopeBorder",
          -- Noice / notify.nvim
          "NotifyINFOBorder", "NotifyWARNBorder", "NotifyERRORBorder"
        },
        exclude_groups = {
          'StatusLine', 'StatusLineNC',
        },
        on_clear = function() end,
      })
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function(plugins, opts)
      local function capitalize(str)
        return (str:gsub("^%l", string.upper))
      end
      local function get_attached_clients()
        local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })
        if #buf_clients == 0 then
          return "LSP Inactive"
        end
        local buf_ft = vim.bo.filetype
        local client_names = {}
        for _, client in pairs(buf_clients) do
          if client.name ~= "copilot" and client.name ~= "null-ls" then
            table.insert(client_names, capitalize(client.name))
          end
        end
        local null_ls = require("null-ls")
        local sources = null_ls.get_sources()
        for _, source in ipairs(sources) do
          if source.filetypes[buf_ft] then
            table.insert(client_names, capitalize(source.name))
          end
        end
        local unique_client_names = {}
        for _, client_name in ipairs(client_names) do
          if not vim.tbl_contains(unique_client_names, client_name) then
            table.insert(unique_client_names, client_name)
          end
        end
        return table.concat(unique_client_names, " | ")
      end
      local auto_theme_custom = require('lualine.themes.auto')
      auto_theme_custom.normal.c.bg = '#292c3c80'
      auto_theme_custom.normal.c.fg = '#89b4fa'
      require('lualine').setup({
        options = {
          icons_enabled = true,
          component_separators = '',
          section_separators = { left = '', right = '' },
          theme = auto_theme_custom,
        },
        sections = {
          lualine_a = { { 'mode', separator = { left = '' }, left_padding = 4, right_padding = 2 } },
          lualine_b = { 'filename', 'branch' },
          lualine_c = {
            '%=', --[[ add your center compoentnts here in place of this comment ]]
          },
          lualine_x = { "encoding", 'fileformat', "diagnostics", get_attached_clients },
          lualine_y = { 'filetype', 'progress' },
          lualine_z = {
            { 'location', separator = { right = '' }, left_padding = 2 },
          },
        },
        -- inactive_sections = {
        --   lualine_a = { 'filename' },
        --   lualine_b = {},
        --   lualine_c = {},
        --   lualine_x = {},
        --   lualine_y = {},
        --   lualine_z = { 'location' },
        -- },
        tabline = {},
        extensions = {},
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    config = function(plugins, opts)
      require('neo-tree').setup({
        filesystem = {
          filtered_items = {
            visible = false, -- When set to false, it hides the filtered items
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
      })
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function(plugins, opts)
      require('Comment').setup()
    end
  },
  {
    "mg979/vim-visual-multi",
  },
  {
    "famiu/bufdelete.nvim",
  },
  {
    "rcarriga/nvim-notify",
    config = function(plugins, opts)
      require("notify").setup({
        timeout = 2000,
        stages = 'fade_in_slide_out'
      })
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function(plugins, opts)
      require("noice").setup({
          notify = {
          enabled = true,
          timeout = 2000,
        },
        lsp = {
          signature = {
            enabled = false,
          },
          hover = {
            enabled = false,
          },
        },
        views = {
          cmdline_popup = {
            position = {
              row = 5,
              col = "50%",
            },
            size = {
              width = 60,
              height = "auto",
            },
          },
          popupmenu = {
            relative = "editor",
            position = {
              row = 8,
              col = "50%",
            },
            size = {
              width = 60,
              height = 10,
            },
            border = {
              style = "rounded",
              padding = { 0, 1 },
            },
            win_options = {
              winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
            },
          },
        },
      })
    end,
  }
}
