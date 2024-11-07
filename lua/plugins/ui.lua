return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      local headers = {
        {
          [[                                   ]],
          [[   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ]],
          [[    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ]],
          [[          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ]],
          [[           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ]],
          [[          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ]],
          [[   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ]],
          [[  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ]],
          [[ ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ]],
          [[ ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ]],
          [[      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ]],
          [[       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ]],
          [[                                   ]],
        },
        {
          [[                                                                       ]],
          [[                                                                     ]],
          [[       ████ ██████           █████      ██                     ]],
          [[      ███████████             █████                             ]],
          [[      █████████ ███████████████████ ███   ███████████   ]],
          [[     █████████  ███    █████████████ █████ ██████████████   ]],
          [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
          [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
          [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
        },
      },
      math.randomseed(os.time())
      local random_header = headers[math.random(#headers)]
      local logo = random_header
      dashboard.section.header.val = vim.split(table.concat(logo, "\n"), "\n")

      -- stylua: ignore
      dashboard.section.buttons.val = {
        dashboard.button("N", " " .. " New file", [[<cmd> ene <BAR> startinsert <cr>]]),
        dashboard.button("F", " " .. " Find File", [[<cmd> Telescope find_files <cr>]]),
        dashboard.button("R", " " .. " Recent Files", [[<cmd> Telescope oldfiles <cr>]]),
        dashboard.button("L", "󰑙 " .. " Load last Session", [[<cmd> SessionRestore <cr>]]),
        dashboard.button("V", " " .. " Configure NeoVim", [[<cmd> lua vim.cmd('cd ' .. vim.fn.stdpath('config')) <cr>]]),
        dashboard.button("Q", " " .. " Quit", "<cmd> qa <cr>"),
      }

      local function update_footer()
        local lazy_stats = require("lazy").stats()
        local plugin_count = lazy_stats.count
        local loaded_plugins = lazy_stats.loaded
        local load_time = lazy_stats.startuptime
        dashboard.section.footer.val = string.format("⚡ Neovim loaded %d/%d plugins in %.0fms", loaded_plugins, plugin_count, load_time)
        pcall(vim.cmd.AlphaRedraw)
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          update_footer()
        end,
      })

      -- Centering logic
      local function center_dashboard()
        local header_height = #dashboard.section.header.val
        local buttons_height = #dashboard.section.buttons.val + 2 -- including padding
        local footer_height = #dashboard.section.footer.val > 0 and 2 or 0 -- 1 line if footer has content

        local total_content_height = header_height + buttons_height + footer_height
        local win_height = vim.fn.winheight(0)

        local padding_lines = math.max(0, math.floor((win_height - total_content_height) / 3))

        dashboard.config.layout = {
          { type = "padding", val = padding_lines },
          dashboard.section.header,
          { type = "padding", val = 3 },
          dashboard.section.buttons,
          { type = "padding", val = 3 },
          dashboard.section.footer,
        }
      end

      -- local function url_decode(str)
      --   str = str:gsub("%%([0-9a-fA-F][0-9a-fA-F])", function(h)
      --     return string.char(tonumber(h, 16))
      --   end)
      --   return str
      -- end

      -- local function session_exists()
      --   local session_dir = vim.fn.stdpath("data") .. "/sessions/"
      --   local cwd = vim.fn.getcwd()
      --   local files = vim.fn.globpath(session_dir, "*.vim", 0, 1)

      --   local session_found = false
      --   for _, file in ipairs(files) do
      --     local filename = file:sub(#session_dir + 1)  -- Get the part after the session_dir
      --     local decoded_name = url_decode(filename:match("([^/]+)$"):gsub(".vim$", ""))  -- Extract and decode the filename

      --     if decoded_name == cwd then
      --       session_found = true
      --       break
      --     end
      --   end

      --   if session_found then
      --     require("notify")("Session exists for this directory!", "success")
      --   else
      --     require("notify")("No session found for this directory.", "warn")
      --   end
      -- end

    center_dashboard()
    alpha.setup(dashboard.opts)
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({
        preset = "modern",
        icons = {
          group = "",
          ellipsis = "",
          breadcrumb = "",
          mappings = true,
        },
        replace = {
          ["<space>"] = "󱁐",
          ["<cr>"] = "󰌑",
          ["<tab>"] = "",
        },
      })
      wk.add({
        { "<leader>c", group = " [c]ode" },

        { "<leader>d", group = "󰧮 [d]ocument" },

        { "<leader>b", group = " [b]uffer" },

        { "<leader>r", group = "󰑕 [r]ename" },

        { "<leader>f", group = " [f]ind" },

        { "<leader>g", group = " [g]it" },

        { "<leader>s", group = " [s]ession" },

        { "<leader>t", group = " [t]oggle" },

        { "<leader>h", group = "󰋖 [h]elp" },
        { "<leader>hk", "<cmd>lua require('which-key').show({ global = false })<CR>", desc = "[k]eymaps", mode = { "n" } },
      })
    end
  },
  { "echasnovski/mini.icons", version = '*', lazy = true },
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { '<leader>e', ':Neotree toggle<CR>', desc = 'Toggle [e]xplorer', silent = true },
      { '<leader>o', ':Neotree focus<CR>', desc = 'Toggle f[o]cus between Explorer & Buffer', silent = true }
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
  },
  {
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
      vim.keymap.set("n", "<leader>q", ":bd<CR>", { noremap = true, silent = true, desc = '[q]uit a buffer' })
      vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true, silent = true, desc = '[w]rite a buffer' })

      vim.keymap.set('n', '<Leader>bp', ':BufferLinePick<CR>', { silent = true ,desc = '[p]ick a buffer' })

      vim.keymap.set('n', '<Leader>b[', ':BufferLineCyclePrev<CR>', { silent = true ,desc = 'Move to the PREV buffer' })
      vim.keymap.set('n', '<Leader>b]', ':BufferLineCycleNext<CR>', { silent = true ,desc = 'Move to the NEXT buffer' })

      vim.keymap.set('n', '<Leader>b<', ':BufferLineMovePrev<CR>', { silent = true ,desc = 'Move buffer to the LEFT' })
      vim.keymap.set('n', '<Leader>b>', ':BufferLineMoveNext<CR>', { silent = true ,desc = 'Move buffer to the RIGHT' })

      vim.keymap.set('n', '<Leader>bc', ':BufferLinePickClose<CR>', { silent = true ,desc = 'Pick a buffer to [c]lose' })
      vim.keymap.set('n', '<Leader>bo', ':BufferLineCloseLeft<CR>:BufferLineCloseRight<CR>', { silent = true ,desc = 'Close all buffers except the current [o]ne' })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
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
          lualine_b = { 'filename', 'branch', 'fileformat', 'encoding' },
          lualine_c = {
            '%=', --[[ add your center compoentnts here in place of this comment ]]
            -- function()
            --   return require('auto-session.lib').current_session_name(true)
            -- end,
          },
          lualine_x = { "diagnostics", get_attached_clients },
          lualine_y = { 'filetype', 'progress' },
          lualine_z = {
            { 'location', separator = { right = '' }, left_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_a = { 'filename' },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'location' },
        },
        tabline = {},
        extensions = {},
      })
    end,
  },
  {
    "folke/noice.nvim",
    lazy = true,
    event = "VimEnter",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
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
  },
  {
    "rcarriga/nvim-notify",
    event = "VimEnter",
    config = function()
      require("notify").setup({
        timeout = 2000,
        stages = 'slide',
        background_colour = "#000000",
        render = "wrapped-compact",
      })
    end,
  },
  {
    "xiyaowong/transparent.nvim",
    config = function()
      require("transparent").setup({
        extra_groups = {
          -- Tabline
          "Winbar", "WinbarNC", "NormalFloat", "FloatBorder", "Folded",
          -- Telescope
          "TelescopeNormal", "TelescopeBorder", "TelescopePromptBorder",
          -- Lualine
          "lualine_c_inactive", "lualine_c_insert", "lualine_c_visual", "lualine_c_command", "lualine_c_replace",
          -- NeoTree
          "NeoTreeNormal", "NeoTreeNormalNC", "NeoTreeWinSeparator",
          -- WhichKey
          "WhichKey", "WhichKeyNormal","WhichKeyFloat", "WhichKeyTitle", "WhichKeyBorder", "MasonNormal", "LazyNormal",
          -- Noice & Notify
          "NoiceCmdline", "NotifyBackground", "MiniNotifyTitle", "NotifyTRACEBody", "NotifyDEBUGBody", "NotifyINFOBody", "NotifyWARNBody", "NotifyERRORBody", "NotifyDEBUGBorder", "NotifyTRACEBorder", "NotifyINFOBorder", "NotifyWARNBorder", "NotifyERRORBorder",
          -- Lsps Misc
          "LspInlayHint", "LspInfoBorder", "DiagnosticVirtualTextHint",
          -- Bufferline
          "BufferCurrent", "BufferCurrentMod", "BufferCurrentSign", "BufferCurrentTarget", "BufferCurrentIndex", "BufferTabpageFill", "BufferLineFill", "Tabline", "TablineFill",
        },
        on_clear = function() end,
      })
      vim.keymap.set("n", "<leader>tt", "<cmd>TransparentToggle<CR>", { desc = "[t]oggle Transparent Mode" })
    end,
  },
  {
    "karb94/neoscroll.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function ()
      require('neoscroll').setup({})
      local keymaps = {
        ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 150; easing = 'sine' }) end;
        ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 150; easing = 'sine' }) end;
      }
    end
  },
}
