return {
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
}
