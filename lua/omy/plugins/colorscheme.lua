return {
  {
    "catppuccin/nvim",
    priority = 1000,

    config = function() -- comentario
      require("catppuccin").setup({
        flavour = "macchiato",
        styles = {
          comments = { "italic" },
        },
        integrations = {
          alpha = true,
          telescope = {
            enabled = true,
            style = "nvchad",
          },
          cmp = true, 
          treesitter = true,
          nvimtree = true,
          vimwiki = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
            },
            inlay_hints = {
                background = true,
            },
          },
        },
      })
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
}
