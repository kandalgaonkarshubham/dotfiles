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
    end
  },
  { "nvzone/timerly",
    dependencies = "nvzone/volt",
    cmd = "TimerlyToggle",
    keys = {
      { "<leader>tm", "<cmd>TimerlyToggle<cr>", desc = "Toggle ti[m]erly" },
    },
    opts = {
      minutes = { 05, 00 },
    }
  },
  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" },
  },
}
