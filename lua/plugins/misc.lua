-- if true then return {} end --! WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  { "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },
  { "seandewar/killersheep.nvim", cmd = "KillKillKill" },
  {
    "rubiin/fortune.nvim",
    event = "VeryLazy",
    config = function()
      require("fortune").setup({
        max_width = 60,
        display_format = "mixed",
        content_type = "mixed",
      })
    end,
  },
  {
    "dbinagi/nomodoro",
    cmd = { "NomoMenu", "NomoWork", "NomoBreak", "NomoStop", "NomoStatus", "NomoTimer", "NomoPause", "NomoContinue" },
    config = function()
      require("nomodoro").setup({
        work_time = 60,
        short_break_time = 10,
        long_break_time = 20,
        break_cycle = 4,
        menu_available = true,
        texts = {
          on_break_complete = "Back to greatness!",
          on_work_complete = "Time to breathe!",
          status_icon = "󰔟 ",
          timer_format = "!%0M:%0S",
        },
        on_work_complete = function()
          vim.fn.jobstart(
            { "mpv", "--no-terminal", "--no-cache", vim.fn.expand("~/.config/nvim/sounds/alert.wav") },
            { detach = true }
          )
        end,
        on_break_complete = function()
          vim.fn.jobstart(
            { "mpv", "--no-terminal", "--no-cache", vim.fn.expand("~/.config/nvim/sounds/alert.wav") },
            { detach = true }
          )
        end,
      })
    end,
    keys = {
      { "<leader>tnm", "<cmd>NomoMenu<cr>", desc = "[n]omodoro [m]enu" },
      { "<leader>tnw", "<cmd>NomoWork<cr>", desc = "[n]omodoro [w]ork" },
      { "<leader>tnb", "<cmd>NomoBreak<cr>", desc = "[n]omodoro [b]reak" },
      { "<leader>tns", "<cmd>NomoStop<cr>", desc = "[n]omodoro [s]top" },
      { "<leader>tnt", "<cmd>NomoStatus<cr>", desc = "[n]omodoro S[t]atus" },
      { "<leader>tnp", "<cmd>NomoPause<cr>", desc = "[n]omodoro [p]ause" },
      { "<leader>tnc", "<cmd>NomoContinue<cr>", desc = "[n]omodoro [c]ontinue" },
    },
  },
  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" },
    keys = {
      { "<leader>typ", "<cmd>Typr<cr>", desc = "T[yp]r" },
      { "<leader>tys", "<cmd>TyprStats<cr>", desc = "T[y]pr [s]tats" },
    },
  },
  {
    "nguyenvukhang/nvim-toggler",
    config = function()
      require("nvim-toggler").setup({
        inverses = {
          ["vim"] = "emacs",
        },
        autoselect_longest_match = false,
      })
      vim.keymap.set({ "n", "v" }, "<leader>i", function()
        require("nvim-toggler").toggle()
      end, { noremap = true, silent = true, desc = "[i]nverse word" })
    end,
  },
}
