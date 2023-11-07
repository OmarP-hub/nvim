return{
  "lervag/vimtex",
  ft = "tex",

  config = function ()
    vim.g.vimtex_view_method = "zathura"
    vim.cmd[[ let maplocalleader = "," ]]
  end
}
