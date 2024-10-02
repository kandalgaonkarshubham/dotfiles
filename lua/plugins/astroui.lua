-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

local function random_theme()
  local themes = { "rose-pine-moon", "poimandres", "catppuccin-mocha", "nord", }
  math.randomseed(os.time())  -- Seed the randomizer
  return themes[math.random(#themes)]  -- Pick and return a random theme
end

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- change colorscheme
    -- colorscheme = "rose-pine-moon",
    colorscheme = random_theme(),
    -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
    highlights = {
      init = { -- this table overrides highlights in all themes
        -- Normal = { bg = "none" },
      },
      -- astrodark = { -- a table of overrides/changes when applying the astrotheme theme
        -- Normal = { bg = "#000000" },
      -- },
    },
    -- Icons can be configured throughout the interface
    icons = {
      -- configure the loading of the lsp in the status line
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },
    status = {
      colors = {
        -- fg = "NONE",
        -- bg = "NONE",
        -- section_fg = "NONE",
        -- section_bg = "NONE",
        -- git_branch_fg = "NONE",
        -- treesitter_fg = "NONE",
        -- scrollbar = "NONE",
        -- git_added = "NONE",
        -- git_changed = "NONE",
        -- git_removed = "NONE",
        -- diag_ERROR = "NONE",
        -- diag_WARN = "NONE",
        -- diag_INFO = "NONE",
        -- diag_HINT = "NONE",
        -- winbar_fg = "NONE",
        -- winbar_bg = "NONE",
        -- winbarnc_fg = "NONE",
        -- winbarnc_bg = "NONE",
        tabline_bg = "NONE",
        tabline_fg = "NONE",
        buffer_fg = "NONE",
        -- buffer_path_fg = "NONE",
        -- buffer_close_fg = "NONE",
        buffer_bg = "NONE",
        buffer_active_fg = "NONE",
        -- buffer_active_path_fg = "NONE",
        -- buffer_active_close_fg = "NONE",
        buffer_active_bg = "NONE",
        -- buffer_visible_fg = "NONE",
        -- buffer_visible_path_fg = "NONE",
        -- buffer_visible_close_fg = "NONE",
        -- buffer_visible_bg = "NONE",
        -- buffer_overflow_fg = "NONE",
        -- buffer_overflow_bg = "NONE",
        -- buffer_picker_fg = "NONE",
        -- tab_close_fg = "NONE",
        -- tab_close_bg = "NONE",
        -- tab_fg = "NONE",
        -- tab_bg = "NONE",
        -- tab_active_fg = "NONE",
        -- tab_active_bg = "NONE",
        -- inactive = "NONE",
        -- normal = "NONE",
        -- insert = "NONE",
        -- visual = "NONE",
        -- replace = "NONE",
        -- command = "NONE",
        -- terminal = "NONE",
      },
    }
  },
}
