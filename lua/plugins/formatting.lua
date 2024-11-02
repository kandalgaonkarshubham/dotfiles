return {
  "nvimtools/none-ls.nvim",
  event = "BufRead",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local augroup = vim.api.nvim_create_augroup("LspAutoFormatting", {})
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettierd,
        require("none-ls.diagnostics.eslint_d"),
      },
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end,
    })
    vim.keymap.set("n", "<leader>df", vim.lsp.buf.format, { desc = "[f]ormat Document" })
  end
}
