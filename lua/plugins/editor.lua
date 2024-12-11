-- if true then return {} end --! WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { 'HiPhish/rainbow-delimiters.nvim' },
    build = ":TSUpdate",
    config = function()
      local rainbow_delimiters = require 'rainbow-delimiters'
      local config = require("nvim-treesitter.configs")
      config = config.setup({
        ensure_installed = {
          "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline",
          "html", "css", "javascript", "typescript", "tsx", "prisma", "json",
        },
        auto_install = true,
        indent = { enable = true },
        highlight = {
          enable = true,
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
        require('rainbow-delimiters.setup').setup {}
      })
    end
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = "▏",
      },
    }
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require("colorizer").setup {}
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "BufRead",
    ft = {
      "html",
      "php",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
    },
    config = function()
      require('nvim-ts-autotag').setup({
        opts = {
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = false -- Auto close on trailing </
        },
        per_filetype = {
          -- ["html"] = {
          --   enable_close = false
          -- }
        }
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = 'BufRead',
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = true,
    init = function()
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "BufRead",
    config = function()
      require("nvim-surround").setup({})
    end
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "BufRead",
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { 'kevinhwang91/promise-async' },
    config = function()
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (' 󰁂 %d '):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
              table.insert(newVirtText, chunk)
          else
              chunkText = truncate(chunkText, targetWidth - curWidth)
              local hlGroup = chunk[2]
              table.insert(newVirtText, {chunkText, hlGroup})
              chunkWidth = vim.fn.strdisplaywidth(chunkText)
              -- str width returned from truncate() may less than 2nd argument, need padding
              if curWidth + chunkWidth < targetWidth then
                  suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
              end
              break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, {suffix, 'String'})
        return newVirtText
      end
      require('ufo').setup({
        provider_selector = function(bufnr, filetype, buftype)
          return {'treesitter', 'indent'}
        end,
        fold_virt_text_handler = handler
      })
    end,
  },
}
