return{
  "lervag/vimtex",
  ft = "tex",

  config = function ()
    vim.g.vimtex_view_method = "skim"
    vim.cmd[[
      let g:vimtex_compiler_latexmk_engines = {
          \ '_'                : '-xelatex', 
          \}
    ]]
    vim.cmd[[ let maplocalleader = "," ]]
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
