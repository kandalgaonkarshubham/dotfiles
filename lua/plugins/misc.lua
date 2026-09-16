vim.pack.add({
  { src = "https://github.com/ThePrimeagen/vim-be-good" },
  { src = "https://github.com/seandewar/killersheep.nvim" },
})

require("killersheep").setup {
  gore = true,
  keymaps = {
    move_left = "h",
    move_right = "l",
    shoot = "<Space>",
  },
}
