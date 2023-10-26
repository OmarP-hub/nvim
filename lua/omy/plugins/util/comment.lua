return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },

  ------------------------
  -- DEF PLUGIN OPTIONS --
  ------------------------
  config = function()
    -- import comment plugin safely
    local comment = require("Comment")
    -- enable comment
    comment.setup()
  end,
}
