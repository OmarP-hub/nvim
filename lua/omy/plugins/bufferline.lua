return {
  "akinsho/bufferline.nvim",
  after = "catppuccin",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      mode = "tabs",
      separator_style = {"|", "|"}
      -- highlights = require("catppuccin.groups.integrations.bufferline").get()
    },
  },
}
