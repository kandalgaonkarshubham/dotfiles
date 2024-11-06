return {
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

    center_dashboard()
    alpha.setup(dashboard.opts)
  end,
}
