-- if true then return {} end --! WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "Kaiser-Yang/blink-cmp-avante",
      "rafamadriz/friendly-snippets",
      {
        "saghen/blink.compat",
        optional = true,
        opts = {},
        version = not vim.g.lazyvim_blink_main and "*",
      },
    },
    event = "InsertEnter",
    opts = {
      sources = {
        compat = {},
        default = { "avante", "lsp", "path", "snippets", "buffer" },
        providers = {
          avante = {
            module = 'blink-cmp-avante',
            name = 'Avante',
            opts = {
              -- options for blink-cmp-avante
            }
          }
        },
      },
      cmdline = {
        enabled = true,
      },
    },
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = '*',
    opts = {
      provider = "claude", -- "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" |
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-7-sonnet-20250219",-- your desired model (or use gpt-4o, etc.)
        timeout = 30000, -- timeout in milliseconds
        temperature = 0, -- adjust if needed
        max_tokens = 4096,
        -- reasoning_effort = "high" -- only supported for reasoning models (o1, etc.)
      },
      behaviour = {
        support_paste_from_clipboard = true,
      },
      file_selector = {
        provider = "snacks", -- "native" | "fzf" | "mini.pick" | "snacks" | "telescope"
        provider_opts = {},
      },
    },
    build = "make",
    dependencies = {
      "zbirenbaum/copilot.lua",
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = {
          "yetone/avante.nvim",
        },
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  }
}
