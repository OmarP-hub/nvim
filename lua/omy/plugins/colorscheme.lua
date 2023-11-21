return {
  {
    "eddyekofo94/gruvbox-flat.nvim",
    priority = 1000,
    enabled = true,
    config = function ()
      vim.g.gruvbox_flat_style = "hard"
      vim.cmd[[colorscheme gruvbox-flat]]
    end
  },
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
          treesitter_context = true,
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
    end,
  },
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000,
    config = function ()
      require("everforest").setup({
        background = "soft",
      })
    end
  },
}
