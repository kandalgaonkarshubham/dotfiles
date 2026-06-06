vim.pack.add({
  -- Treesitter
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },

  -- Lualine
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },

  -- IBL
  { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
  { src = "https://github.com/HiPhish/rainbow-delimiters.nvim" },

  -- Snacks
  { src = "https://github.com/folke/snacks.nvim" },

  -- Mini
  { src = "https://github.com/nvim-mini/mini.surround" },
  { src = "https://github.com/nvim-mini/mini.extra" },
  { src = "https://github.com/nvim-mini/mini.pick" },

  -- Git
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/esmuellert/vscode-diff.nvim" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },
})

--------------------------------------------------------------------------------
-- Treesitter
--------------------------------------------------------------------------------

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
  "python",
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})

--------------------------------------------------------------------------------
-- Lualine
--------------------------------------------------------------------------------

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

require("lualine").setup({
  options = {
    globalstatus = true,

    disabled_filetypes = {
      statusline = {
        "dashboard",
        "alpha",
        "typr",
        "ministarter",
        "snacks_dashboard",
      },
    },

    theme = "auto",
    component_separators = "",
    section_separators = {
      left = "",
      right = "",
    },
  },

  sections = {
    lualine_a = {
      {
        "mode",
        separator = { left = "" },
        right_padding = 2,
      },
    },

    lualine_b = {
      "branch",

      {
        function()
          if vim.bo.modified then
            return ""
          elseif not vim.bo.modifiable or vim.bo.readonly then
            return ""
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
        path = 0,
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
      {
        "location",
        separator = { right = "" },
        left_padding = 2,
      },
    },
  },
})

--------------------------------------------------------------------------------
-- indent-blankline + rainbow-delimiters
--------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------
-- Snacks
--------------------------------------------------------------------------------

require("snacks").setup({
  picker = {
    icons = {
      git = {
        enabled = true,
        commit = "󰜘 ",
        added = " ",
        modified = "○",
        ignored = "◌ ",
        unstaged = " ",
        staged = "󰸞 ",
        untracked = " ",
        renamed = "󰑕 ",
        deleted = "󰆴 ",
        unmerged = " ",
      },
    },
  },

  explorer = {},
  lazygit = {},
  terminal = {}
})

local map = vim.keymap.set

map("n", "<leader><space>", function()
  Snacks.picker.smart()
end, { desc = "Smart Find Files" })

map("n", "<leader>/", function()
  Snacks.picker.grep()
end, { desc = "Grep" })

map("n", "<leader>:", function()
  Snacks.picker.command_history()
end, { desc = "Command History" })

map("n", "<leader>n", "<cmd>Noice history<cr>", {
  desc = "Notification History",
})

map("n", "<leader>e", function()
  Snacks.explorer()
end, { desc = "File Explorer" })

-- Git

map("n", "<leader>gg", function()
  Snacks.lazygit()
end, { desc = "LazyGit" })

map("n", "<leader>gl", function()
  Snacks.picker.git_log()
end, { desc = "Git Log" })

map("n", "<leader>gd", function()
  Snacks.picker.git_diff()
end, { desc = "Git Diff (Hunks)" })

-- GitHub

map("n", "<leader>gi", function()
  Snacks.picker.gh_issue()
end, { desc = "GitHub Issues (open)" })

map("n", "<leader>gI", function()
  Snacks.picker.gh_issue({ state = "all" })
end, { desc = "GitHub Issues (all)" })

map("n", "<leader>gp", function()
  Snacks.picker.gh_pr()
end, { desc = "GitHub Pull Requests (open)" })

map("n", "<leader>gP", function()
  Snacks.picker.gh_pr({ state = "all" })
end, { desc = "GitHub Pull Requests (all)" })

-- LSP

map("n", "gd", function()
  Snacks.picker.lsp_definitions()
end, { desc = "Goto Definition" })

map("n", "gD", function()
  Snacks.picker.lsp_declarations()
end, { desc = "Goto Declaration" })

map("n", "gI", function()
  Snacks.picker.lsp_implementations()
end, { desc = "Goto Implementation" })

map("n", "gy", function()
  Snacks.picker.lsp_type_definitions()
end, { desc = "Goto Type Definition" })

map("n", "<leader>ss", function()
  Snacks.picker.lsp_symbols()
end, { desc = "LSP Symbols" })

--------------------------------------------------------------------------------
-- Mini
--------------------------------------------------------------------------------

require("mini.surround").setup()

require("mini.extra").setup()

map("n", "<leader>xx", MiniExtra.pickers.diagnostic, {
  desc = "Diagnostics",
})

--------------------------------------------------------------------------------
-- Git
--------------------------------------------------------------------------------

require("gitsigns").setup({
  current_line_blame = true,
  on_attach = function(bufnr)
    local gitsigns = require("gitsigns")

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gitsigns.nav_hunk("next")
      end
    end, { desc = "Next Git hunk" })

    map("n", "[c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gitsigns.nav_hunk("prev")
      end
    end, { desc = "Previous Git hunk" })

    -- Actions
    map("n", "<leader>ghs", gitsigns.stage_hunk, { desc = "Stage hunk" })
    map("n", "<leader>ghr", gitsigns.reset_hunk, { desc = "Reset hunk" })

    map("v", "<leader>ghs", function()
      gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "Stage selected hunk" })

    map("v", "<leader>ghr", function()
      gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "Reset selected hunk" })

    map("n", "<leader>ghS", gitsigns.stage_buffer, { desc = "Stage buffer" })
    map("n", "<leader>ghR", gitsigns.reset_buffer, { desc = "Reset buffer" })

    map("n", "<leader>ghp", gitsigns.preview_hunk, { desc = "Preview hunk" })
    map("n", "<leader>ghi", gitsigns.preview_hunk_inline, { desc = "Preview hunk inline" })

    map("n", "<leader>ghb", function()
      gitsigns.blame_line({ full = true })
    end, { desc = "Blame current line" })

    map("n", "<leader>ghd", gitsigns.diffthis, { desc = "Diff current file" })

    map("n", "<leader>ghD", function()
      gitsigns.diffthis("~")
    end, { desc = "Diff against previous commit" })

    map("n", "<leader>ghQ", function()
      gitsigns.setqflist("all")
    end, { desc = "Git hunks → quickfix (all)" })

    map("n", "<leader>ghq", gitsigns.setqflist, { desc = "Git hunks → quickfix" })

    -- Toggles
    map("n", "<leader>gtb", gitsigns.toggle_current_line_blame, {
      desc = "Toggle Git blame",
    })

    map("n", "<leader>gtw", gitsigns.toggle_word_diff, {
      desc = "Toggle word diff",
    })

    -- Text object
    map({ "o", "x" }, "ih", gitsigns.select_hunk, {
      desc = "Select Git hunk",
    })
  end,
})

require("vscode-diff").setup()
vim.keymap.set("n", "<leader>gc", ":CodeDiff<cr>", {
  noremap = true,
  silent = true,
  desc = "Git Diff (vs[c]ode)",
})
