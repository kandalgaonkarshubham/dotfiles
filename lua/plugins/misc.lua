-- if true then return {} end --! WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  { "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },
  { "seandewar/killersheep.nvim", cmd = "KillKillKill" },
  {
    "rubiin/fortune.nvim",
    config = function()
      require("fortune").setup({
        max_width = 60,
        display_format = "mixed",
        content_type = "mixed",
      })
    end
  },
}
