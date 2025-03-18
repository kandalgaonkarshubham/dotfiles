-- if true then return {} end --! WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  {
    "kevinhwang91/nvim-ufo",
    event = "BufRead",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (" 󰁂 %d "):format(endLnum - lnum)
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
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "String" })
        return newVirtText
      end
      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
        fold_virt_text_handler = handler,
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    opts = {
      window = {
        width = 30,
        mappings = {
          ["oa"] = "avante_add_files",
        },
      },
      filesystem = {
        filtered_items = {
          never_show = {
            "node_modules",
          },
        },
        commands = {
          avante_add_files = function(state)
            local node = state.tree:get_node()
            local filepath = node:get_id()
            local relative_path = require("avante.utils").relative_path(filepath)

            local sidebar = require("avante").get()

            local open = sidebar:is_open()
            -- ensure avante sidebar is open
            if not open then
              require("avante.api").ask()
              sidebar = require("avante").get()
            end

            sidebar.file_selector:add_selected_file(relative_path)

            -- remove neo tree buffer
            if not open then
              sidebar.file_selector:remove_selected_file("neo-tree filesystem [1]")
            end
          end,
        },
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        {
          mode = { "n", "v" },
          { "<leader>a", group = "Avante", icon = { icon = "󰭻 ", color = "magenta" } },
          { "<leader>t", group = "Toggle", icon = { icon = " ", color = "cyan" } },
        },
      },
    },
  },
}
