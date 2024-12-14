-- if true then return {} end --! WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  --!! Git --
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gl", "<cmd>LazyGit<cr>", silent = true, desc = "[l]azyGit" },
    }
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', 'g]', function()
          if vim.wo.diff then
            vim.cmd.normal { 'g]', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git [c]hange' })

        map('n', 'g[', function()
          if vim.wo.diff then
            vim.cmd.normal { 'g[', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git [c]hange' })

        -- Actions
        -- visual mode
        map('v', '<leader>gs', function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = '[s]tage git hunk' })
        map('v', '<leader>gr', function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = '[r]eset git hunk' })
        -- normal mode
        map('n', '<leader>gs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
        map('n', '<leader>gr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
        map('n', '<leader>gS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
        map('n', '<leader>gu', gitsigns.undo_stage_hunk, { desc = 'git [u]ndo stage hunk' })
        map('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
        map('n', '<leader>gp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
        map('n', '<leader>gb', gitsigns.blame_line, { desc = 'git [b]lame line' })
        map('n', '<leader>gd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
        map('n', '<leader>gD', function() gitsigns.diffthis '@' end, { desc = 'git [D]iff against last commit' })
        -- Toggles
        map('n', '<leader>gtb', gitsigns.toggle_current_line_blame, { desc = 'Toggle git show [b]lame line' })
        map('n', '<leader>gtD', gitsigns.toggle_deleted, { desc = 'Toggle git show [D]eleted' })
      end,
    },
  },
  --!! Telescope --
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find [f]iles" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live [g]rep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "List [b]uffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "[h]elp Tags" },
    },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    -- build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    build = 'make',
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
    "gennaro-tedesco/nvim-peekup",
    cmd = "PeekupOpen",
  },
  --!! Workflow --
  {
    "tris203/precognition.nvim",
    event = "BufRead",
    opts = {
      highlightColor = { fg = "#8a8583" },
    },
  },
  {
    "m4xshen/hardtime.nvim",
    event = "BufRead",
    dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    opts = {
      -- disabled_keys = {
      --   ["<Up>"] = { "n", "x" },
      --   ["<Down>"] = { "n", "x" },
      --   ["<Left>"] = { "n", "x" },
      --   ["<Right>"] = { "n", "x" },
      -- },
    }
  },
  {
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "<leader>to", "<cmd>Outline<CR>", desc = "Toggle [o]utline" },
    },
    opts = {},
  },
  {
    "folke/twilight.nvim",
    cmd = { "Twilight" },
    event = "BufRead",
    opts = {
      -- context = 10, -- amount of lines we will try to show around the current line
      -- exclude = {}, -- exclude these filetypes
    },
    keys = {
      { "<leader>tw", "<cmd>Twilight<cr>", desc = "Toggle t[w]ilight" },
    },
  },
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({
        enable_cmp_source = false,
        enable_chat = false,
        virtual_text = {
          enabled = true,
          key_bindings = {
            -- Accept the current completion.
            accept = "<Tab>",
            -- Accept the next word.
            accept_word = false,
            -- Accept the next line.
            accept_line = false,
            -- Clear the virtual text.
            clear = false,
            -- Cycle to the next completion.
            next = "<M-]>",
            -- Cycle to the previous completion.
            prev = "<M-[>",
          }
        }
      })
      require('codeium.virtual_text').set_statusbar_refresh(
        function()
          require('lualine').refresh()
        end
      )
    end
  },
  {
    "Pocco81/auto-save.nvim",
    cmd = { "ASToggle" },
    keys = {
      { "<leader>ta", "<cmd>ASToggle<CR>", desc = "Toggle [a]utosave" },
    },
    config = function()
      require("auto-save").setup {
        trigger_events = { "InsertLeave" },
        execution_message = {
          message = nil,
          cleaning_interval = 0,
        },
      }
    end,
  },
  {
    "atiladefreitas/dooing",
    config = function()
      require("dooing").setup({})
    end,
  },
  {
    "ellisonleao/glow.nvim",
    cmd = "Glow",
    config = true,
  },
  {
    "mistricky/codesnap.nvim",
    build = "make",
    keys = {
      { "<leader>cc", ":CodeSnap<cr>", mode = "x", noremap = true, silent = true, desc = "Copy selected code snapshot into [c]lipboard" },
      { "<leader>cs", ":CodeSnapSave<cr>", mode = "x", noremap = true, silent = true, desc = "[s]ave selected code snapshot locally" },
    },
    opts = {
      save_path = "~/Pictures/nvim",
      has_breadcrumbs = true,
      show_workspace = true,
      bg_padding = 0,
      watermark = "",
    },
  },
}
