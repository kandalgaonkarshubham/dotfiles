return {
  {
    "rcarriga/nvim-notify",
    config = function(plugins, opts)
      require("notify").setup({
        timeout = 2000,
        stages = 'fade_in_slide_out',
        background_colour = "#000000",
      })
    end,
  },
}
