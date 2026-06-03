-- if true then return {} end --! WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  {
    "nvim-mini/mini.cmdline",
    version = false,
    config = function()
      require("mini.cmdline").setup()
    end,
  }
}
