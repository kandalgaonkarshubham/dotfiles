return {
  "stevearc/resession.nvim",
  cmd = { "SessionLoad", "SessionSave", "SessionDelete" },
  config = function()
    local resession = require("resession")
    resession.setup()
    vim.keymap.set("n", "<leader>ss", resession.save, { desc = "[s]ave Session" })
    vim.keymap.set("n", "<leader>sl", resession.load, { desc = "[l]oad Session" })
    vim.keymap.set("n", "<leader>sd", resession.delete, { desc = "[d]elete Session" })
  end
}
