return {
  {
    "karb94/neoscroll.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function ()
      require('neoscroll').setup({})
      local keymaps = {
        ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 150; easing = 'sine' }) end;
        ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 150; easing = 'sine' }) end;
      }
    end
  },
}
