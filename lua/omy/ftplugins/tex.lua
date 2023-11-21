return{
  "lervag/vimtex",
  ft = "tex",

  config = function ()
    vim.g.maplocalleader = ","
    vim.g.vimtex_compiler_latexmk_engines = {["_"] = "-lualatex"}
    vim.g.vimtex_compiler_latexmk = { ["aux_dir"] = "./build" }
    vim.g.vimtex_view_method = "skim"
    vim.g.vimtex_quickfix_mode = 0

    vim.cmd[[
      function! s:TexFocusVim() abort
        silent execute "!open -a iTerm2"
        redraw!
      endfunction
    ]]
    vim.cmd[[
      augroup vimtex_event_focus
        au!
        au User VimtexEventViewReverse call s:TexFocusVim()
      augroup END
    ]]
  end
}
