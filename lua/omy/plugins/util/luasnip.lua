return {
  "L3MON4D3/LuaSnip",
  version = "v2.0.0",
  build = "make install_jsregexp",

  require("luasnip").setup({
    region_check_events = "CursorMoved",
    update_events = "TextChanged, TextChangedI",
    enable_autosnippets = true,
    require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/LuaSnip/"})
  })
}
