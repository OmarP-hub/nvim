return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  ------------------------
  -- DEF PLUGIN OPTIONS --
  ------------------------
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count

    -- configure lualine theme and custom 
    -- section for lazy status 
    lualine.setup({
      options = {
        theme = "gruvbox-flat", 
      },
      sections = {
        lualine_y = {},
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          -- { "encoding" },
          -- { "fileformat" },
          { "filetype" },
        },
      },
    })
  end,
}
