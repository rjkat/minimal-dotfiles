" vim:et:sw=2:ts=2

" Plugin configuration like the code written in vimrc.
" This configuration is executed *before* a plugin is loaded.
function! s:on_load_pre()
  if system('uname -s') == "Darwin\n"
    set rtp+=/usr/local/opt/fzf
  else
    set rtp+=~/.fzf
  endif
endfunction

" Plugin configuration like the code written in vimrc.
" This configuration is executed *after* a plugin is loaded.
function! s:on_load_post()
  " map ctrl-p to FZF and prevent opening files in nerdtreee buffer
  nnoremap <silent> <expr> <c-p> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":ProjectFiles\<cr>"
endfunction

" This function determines when a plugin is loaded.
"
" Possible values are:
" * 'start' (a plugin will be loaded at VimEnter event)
" * 'filetype=<filetypes>' (a plugin will be loaded at FileType event)
" * 'excmd=<excmds>' (a plugin will be loaded at CmdUndefined event)
" <filetypes> and <excmds> can be multiple values separated by comma.
"
" This function must contain 'return "<str>"' code.
" (the argument of :return must be string literal)
function! s:loaded_on()
  return 'start'
endfunction

" Dependencies of this plugin.
" The specified dependencies are loaded after this plugin is loaded.
"
" This function must contain 'return [<repos>, ...]' code.
" (the argument of :return must be list literal, and the elements are string)
" e.g. return ['github.com/tyru/open-browser.vim']
function! s:depends()
  return []
endfunction
