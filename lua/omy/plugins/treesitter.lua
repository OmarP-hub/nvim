return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",

    ------------------------
    -- DEF PLUGIN OPTIONS --
    ------------------------
    config = function()
      -- import nvim-treesitter plugin
      local treesitter = require("nvim-treesitter.configs")

      -- configure treesitter
      treesitter.setup({ -- enable syntax highlighting
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },

        -- enable indentation
        indent = { enable = true },

        -- ensure these language parsers are installed
        ensure_installed = {
          "c",       -- REQUIRED
          "lua",     -- REQUIRED
          "vim",     -- REQUIRED
          "vimdoc",  -- REQUIRED
          "query",   -- REQUIRED
          "json",
          "markdown",
          "markdown_inline",
          "bash",
          "gitignore",
        },
      })
    end,
  },
}
